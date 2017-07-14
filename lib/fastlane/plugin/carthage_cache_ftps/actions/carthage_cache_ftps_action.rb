require 'carthage_cache'

module Fastlane
  module Actions
    class CarthageCacheFtpsAction < Action
      def self.run(params)
        FastlaneCore::PrintTable.print_values(config: params, title: "Summary for Carthage Cache FTPS")

        host = params.values[:host]
        remote_subfolder = params.values[:subfolder]
        username = params.values[:username]
        password = params.values[:password] || PasswordHelper.new.password(host, username)

        config = {
                  bucket_name: remote_subfolder,
                  aws_s3_client_options: {
                    region: host,
                    aws_access_key_id: username,
                    secret_access_key: password,
                    access_key_id: "bla"
                    }
                  }

        puts application.inspect

        project_directory = params.values[:project_directory]
        application = CarthageCache::Application.new(project_directory, true, config, repository: FTPRepository)
        
        command = params.values[:command]

        case command.to_sym
        when :install
          exit 1 unless application.install_archive
        when :publish
          exit 1 unless application.create_archive
        end
      end

      def self.description
        "Allows to publish or install the carthage builds via ftps to avoid recompilation"
      end

      def self.authors
        ["Wolfgang Lutz"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "This plugin extends the carthage_cache_gem with ftps functionality, to be able to cache the built carthage libraries remotely on an ftp server."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :host,
                                  env_name: "CARTHAGE_CACHE_FTPS_HOST",
                               description: "The ftps host to use for carthage cache",
                                  optional: false,
                                      type: String,
                             default_value: "127.0.0.1",
                              short_option: "h"),
          FastlaneCore::ConfigItem.new(key: :username,
                                  env_name: "CARTHAGE_CACHE_FTPS_USERNAME",
                               description: "The ftps username to use for carthage cache",
                                  optional: false,
                                      type: String,
                             default_value: "anonymous",
                              short_option: "u"),
          FastlaneCore::ConfigItem.new(key: :password,
                                  env_name: "CARTHAGE_CACHE_FTPS_PASSWORD",
                               description: "The ftps password to use for carthage cache. If not given, keychain is used",
                                  optional: true,
                                      type: String,
                                 sensitive: true,
                              short_option: "p"),
          FastlaneCore::ConfigItem.new(key: :command,
                                  env_name: "CARTHAGE_CACHE_COMMAND",
                               description: "The carthage cache command to use. Allowed values: publish, install",
                                  optional: false,
                                      type: String,
                             default_value: "install",
                              short_option: "c",
                              verify_block: proc do |value|
                                              UI.user_error!("Unknown carthage cache command. Allowed: install, publish") unless ["install", "publish"].include?(value)
                                            end),
          FastlaneCore::ConfigItem.new(key: :subfolder,
                                  env_name: "CARTHAGE_CACHE_FTPS_SUBFOLDER",
                               description: "The subfolder to use for carthage cache",
                                  optional: true,
                                      type: String,
                             default_value: "carthage_cache",
                              short_option: "f"),
          FastlaneCore::ConfigItem.new(key: :project_directory,
                                  env_name: "FL_CARTHAGE_PROJECT_DIRECTORY",
                               description: "Define the directory containing the Carthage project",
                                  optional: true,
                                      type: String,
                             default_value: ".",
                              short_option: "l")
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
