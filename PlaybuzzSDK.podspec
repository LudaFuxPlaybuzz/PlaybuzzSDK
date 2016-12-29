#
# Be sure to run `pod lib lint PlaybuzzSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PlaybuzzSDK'
  s.version          = '0.1.4'
  s.summary          = 'Embed your our Playbuzz quiz via PlaybuzzSDK.'
  s.homepage         = 'https://github.com/LudaFuxPlaybuzz/playbuzz-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luda Fux' => 'luda@playbuzz.com' }
  s.source           = { :git => 'https://github.com/LudaFuxPlaybuzz/playbuzz-ios-sdk.git', :tag => 'v0.1.4' }
  s.social_media_url = 'https://www.facebook.com/playbuzz/'
  s.ios.deployment_target = '8.0'
  s.source_files = 'PlaybuzzSDK/**/*'

end
