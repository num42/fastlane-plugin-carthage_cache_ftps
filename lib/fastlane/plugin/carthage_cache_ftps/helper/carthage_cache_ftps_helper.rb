require "fastlane_core"

module Fastlane
  module Helper
    class CarthageCacheFtpsHelper
      UI = FastlaneCore::UI

      def self.ask_password(message: "Passphrase for FTP: ", confirm: true)
        ensure_ui_interactive
        loop do
          password = UI.password(message)
          if confirm
            password2 = UI.password("Type passphrase again: ")
            if password == password2
              return password
            end
          else
            return password
          end
          UI.error("Passphrases differ. Try again")
        end
      end

      def self.ensure_ui_interactive
        raise "This code should only run in interactive mode" unless UI.interactive?
      end

      private_class_method :ensure_ui_interactive
    end
  end
end
