source "https://rubygems.org"

# Xcode
gem 'cocoapods', '1.10.1'
gem 'fastlane', '2.189.0'

# Danger
gem 'danger'
gem 'danger-swiftlint', '0.16.0'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
