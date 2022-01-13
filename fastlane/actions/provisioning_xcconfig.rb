# coding: utf-8
require 'fileutils'
require 'tempfile'

module Fastlane
  module Actions
    class ProvisioningXcconfigAction < Action

      def self.install_match(type, team_id, app_identifier, keychain_name, keychain_password)
        begin
          other_action.match(type: type,
                             team_id: team_id,
                             app_identifier: app_identifier,
                             keychain_name: keychain_name,
                             keychain_password: keychain_password)
        rescue => e
          other_action.create_keychain(name: keychain_name,
                                       password: keychain_password,
                                       unlock: true, timeout: 3600)
          retry
        end
      end

      def self.get_app_identifier(path)
        return other_action.get_xcconfig_value(
                 path: path,
                 name: 'PRODUCT_BUNDLE_IDENTIFIER'
               )
      end

      def self.get_team_id(path)
        return other_action.get_xcconfig_value(
          path: path,
          name: 'DEVELOPMENT_TEAM'
        )
      end

      def self.run(params)
        params.load_configuration_file("Provisioningfile")

        app_identifier = get_app_identifier(params[:xcconfig])
        team_id = get_team_id(params[:xcconfig])
        type = params[:provisioning_type]

        install_match(type,
                      team_id,
                      app_identifier,
                      params[:keychain_name],
                      params[:keychain_pass])
      end

      def self.description
        "Xcode Project を構築します"
      end

      def self.available_options

        [
          FastlaneCore::ConfigItem.new(key: :xcconfig,
                                       description: 'A xcconfig that containes bundle identifier and team id',
                                       type: String),

          FastlaneCore::ConfigItem.new(key: :keychain_name,
                                       description: 'A keychain name that saves certificate that is installed by match',
                                       type: String),

          FastlaneCore::ConfigItem.new(key: :keychain_pass,
                                       description: 'A keychain pass that saves certificate that is installed by match',
                                       type: String),

          FastlaneCore::ConfigItem.new(key: :provisioning_type,
                                       description: "Method used to export the archive. Valid values are: app-store, validation, ad-hoc, package, enterprise, development, developer-id and mac-application",
                                       type: String,
                                       verify_block: proc do |value|
                                         av = %w(app-store validation ad-hoc package enterprise development developer-id mac-application)
                                         UI.user_error!("Unknown provisioning type '#{value}', must be: #{av}") unless av.include?(value)
                                       end),
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
