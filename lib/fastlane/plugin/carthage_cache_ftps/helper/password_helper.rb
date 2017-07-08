require 'security'
require 'shellwords'

class PasswordHelper
    UI = FastlaneCore::UI
  
    def server_name(host, username)
      ["carthage_cache_ftps", host, username].join("_")
    end

    def password(host, username)
      password = ENV["CARTHAGE_CACHE_FTPS_PASSWORD"]
      unless password
        item = Security::InternetPassword.find(server: server_name(host, username))
        password = item.password if item
      end

      unless password
        if !UI.interactive?
          UI.error "Neither the CARTHAGE_CACHE_FTPS_PASSWORD environment variable nor the local keychain contained a password."
          UI.error "Bailing out instead of asking for a password, since this is non-interactive mode."
          UI.user_error!("Try setting the CARTHAGE_CACHE_FTPS_PASSWORD environment variable, or temporarily enable interactive mode to store a password.")
        else
          UI.important "Enter the passphrase that should be used to login to the ftps"
          UI.important "This passphrase is specific per host and username and will be stored in your local keychain"
          password = Fastlane::Helper::CarthageCacheFtpsHelper.ask_password(confirm: false)
          store_password(host, username, password)
        end
      end

      return password
    end

    def store_password(host, username, password)
      Security::InternetPassword.add(server_name(host, username), "", password)
    end
end
