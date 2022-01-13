# coding: utf-8
require 'fileutils'
require 'tempfile'

module Fastlane
  module Actions
    class ProjectgenAction < Action

      def self.run(params)
        params.load_configuration_file("Projectgenfile")
        other_action.xcodegen(spec: params[:xcodegen_conf])

        if params[:image_xcassets] != nil then
          require_relative '../asset_gen.rb'
          make_asset_code(params[:image_xcassets])
        end

        if params[:swiftgen_conf] != nil then
          command = <<-EOS

          cd ./Packages/View
          SDKROOT=(xcrun --sdk macosx --show-sdk-path)
          swift run -c release swiftgen config run --config #{params[:swiftgen_conf]}

          EOS

          sh(command)
        end

      end

      def self.description
        "Xcode Project を構築します"
      end

      def self.available_options

        [
          FastlaneCore::ConfigItem.new(key: :xcodegen_conf,
                                       description: 'A xcconfig that containes bundle identifier and team id',
                                       type: String),

          FastlaneCore::ConfigItem.new(key: :swiftgen_conf,
                                       description: 'swiftgen config file path',
                                       optional: true,
                                       type: String),

          FastlaneCore::ConfigItem.new(key: :image_xcassets,
                                       description: 'xcassets file path',
                                       optional: true,
                                       type: String),
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
