Pod::Spec.new do |s|
  s.name             = 'testappio'
  s.version          = '1.0.1'
  s.summary          = 'TestApp.io SDK with your Flutter app'
  s.description      = <<-DESC
TestApp.io SDK for Flutter allows seamless integration of TestApp.io's comprehensive feedback and performance monitoring tools into Flutter applications. It enables the capture of insightful feedback and crucial events with minimal effort to enhance app quality and user experience.
                       DESC
  s.homepage         = 'https://testapp.io/sessions'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'TestApp.io' => 'support@testapp.io' }
  s.source           = { :git => 'https://github.com/testappio/flutter-sdk.git', :tag => '1.0.0' }
  s.source_files     = 'Classes/**/*'
  s.platform         = :ios, '13.0'

  s.dependency 'Flutter'
  s.dependency 'TestAppIOSDK', '~> 2.0'

  # Exclude architectures not supported by Flutter.framework
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
