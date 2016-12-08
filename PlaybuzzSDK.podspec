#
# Be sure to run `pod lib lint PlaybuzzSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PlaybuzzSDK'
  s.version          = '0.1.0'
  s.summary          = 'Embed your our Playbuzz quiz via PlaybuzzSDK.'
  s.description      = <<-DESC
This pod allows you to intergate Playbuzz quizes with just couple of lines. 
                       DESC
  s.homepage         = 'https://github.com/LudaFuxPlaybuzz/playbuzz-ios-sdk'
#s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luda Fux' => 'luda@playbuzz.com' }
  s.source           = { :git => 'https://github.com/LudaFuxPlaybuzz/playbuzz-ios-sdk.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/playbuzz/'
  s.ios.deployment_target = '8.0'
  s.source_files = 'PlaybuzzSDK/Classes/**/*'

  # s.resource_bundles = {
  #   'PlaybuzzSDK' => ['PlaybuzzSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
