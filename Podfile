# coding: utf-8
platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

workspace 'main.xcworkspace'

source 'https://cdn.cocoapods.org/'

abstract_target 'app' do

  pod 'SwiftLint', '0.33.0'

  target 'main' do
    project 'main/main.xcodeproj'
    target 'mainTests' do
      inherit! :search_paths
    end
  end

  target 'View' do
    project 'View/View.xcodeproj'
    pod 'SwiftGen', '6.0.0'

    target 'ViewTests' do
    end
  end

  target 'UseCase' do
    project 'UseCase/UseCase.xcodeproj'
    target 'UseCaseTests' do
    end
  end

  target 'DataSource' do
    project 'DataSource/DataSource.xcodeproj'
    target 'DataSourceTests' do
    end
  end

end
