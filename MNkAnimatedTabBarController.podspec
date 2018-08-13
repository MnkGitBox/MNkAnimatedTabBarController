#
# Be sure to run `pod lib lint MNkAnimatedTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MNkAnimatedTabBarController'
  s.version          = '0.1.5'
  s.summary          = 'iOS Tab bar controller with animated button'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Custom created tab bar controller with animated button.if you want to static button with no aniamtion you still can do it with this simple libbary. you have to do programatically way un till to developed story board version.'

  s.homepage         = 'https://github.com/MnkGitBox/MNkAnimatedTabBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Malith Nadeeshan' => 'malith.mnk93@gmail.com' }
  s.source           = { :git => 'https://github.com/MnkGitBox/MNkAnimatedTabBarController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Classes/**/*'
  s.swift_version = '4.0'
  
  # s.resource_bundles = {
  #   'MNkAnimatedTabBarController' => ['MNkAnimatedTabBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    s.dependency 'lottie-ios'
end
