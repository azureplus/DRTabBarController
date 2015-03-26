#
# Be sure to run `pod lib lint DRTabBarController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DRTabBarController"
  s.version          = "0.1.0"
  s.summary          = "An iOS tab bar controller, just like the native UITabBarController but with the tabs on top."
s.description      = <<-DESC
Because iOS own UITabBarController does not support putting the tabs on top, I decided to write DRTabBarController. The idea is to mimic the native tab controller in every other way, just put the tabs on top instead.
DESC
  s.homepage         = "https://github.com/runemalm/DRTabBarController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "David Runemalm" => "david.runemalm@gmail.com" }
  s.source           = { :git => "https://github.com/runemalm/DRTabBarController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/DavidRunemalm'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'DRTabBarController' => ['Pod/Assets/*.png', 'Pod/Classes/*.xib']
  }
  s.resources = ['Pod/Classes/**/*.{xib}', 'Pod/Assets/**/*.{png}']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end