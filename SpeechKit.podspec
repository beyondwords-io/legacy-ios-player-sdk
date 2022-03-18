Pod::Spec.new do |s|
  s.name = 'SpeechKit'
  s.version = '1.0.8'
  s.license = 'Propietary'
  s.summary = 'BeyondWords iOS SDK'
  s.homepage = 'https://beyondwords.io/'
  s.authors = { 'BeyondWords' => 'hello@beyondwords.io' }
  s.source = { :git => 'https://github.com/SpeechKit/speechkit-ios-sdk-public.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "BeyondWords.xcframework"
end
