require 'carthage_cache'

module Fastlane
  module Actions
    class CarthageCacheAction < Action
      def self.run(params)
        FastlaneCore::PrintTable.print_values(config: params, title: "Summary for Carthage Cache")

        application = CarthageCache::Application.new(".", true, {})

        command = params.values[:carthage_cache_command]

        case command.to_sym
        when :install
          exit 1 unless application.install_archive
        when :publish
          exit 1 unless application.create_archive
        end
      end

      def self.description
        "Allows to publish or install the carthage builds to AWS to avoid recompilation. Needs a configuration created by 'carthage_cache config'"
      end

      def self.authors
        ["Wolfgang Lutz"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This action uses the carthage_cache_gem to cache the built carthage libraries remotely on AWS."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :carthage_cache_command,
                                  env_name: "CARTHAGE_CACHE_COMMAND",
                               description: "The carthage cache command to use. Allowed values: publish, install",
                                  optional: false,
                                      type: String,
                             default_value: "install",
                              short_option: "c",
                              verify_block: proc do |value|
                                              UI.user_error!("Unknown carthage cache command. Allowed: install, publish") unless ["install", "publish"].include?(value)
                                            end)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
