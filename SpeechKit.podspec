Pod::Spec.new do |s|
  s.name = 'SpeechKit'
  s.version = '1.0.0'
  s.license = 'Propietary'
  s.summary = 'SpeechKit iOS SDK'
  s.homepage = 'https://speechkit.io/'
  s.authors = { 'SpeechKit' => 'hello@speechkit.io' }
  s.source = { :git => 'https://github.com/SpeechKit/speechkit-ios-sdk-public.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = "SpeechKit.xcframework"
end
