#
# Be sure to run `pod lib lint YBAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YBAlertView'
  s.version          = '0.1.0'
  s.summary          = 'iOS 定制化AlertView，不基于系统提供的UIAlertView和UIAlertViewController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
       iOS平台下的弹框视图，支持标题栏颜色、弹框内容、按钮的完全自定义.不基于系统提供的UIAlertView和UIAlertViewController
                       DESC

  s.homepage         = 'https://github.com/sdutlyb/YBAlertView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bin' => '386026448@qq.com' }
  s.source           = { :git => 'https://github.com/sdutlyb/YBAlertView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YBAlertView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YBAlertView' => ['YBAlertView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation', 'QuartzCore'
  # s.dependency 'AFNetworking', '~> 2.3'
end
