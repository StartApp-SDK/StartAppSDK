Pod::Spec.new do |s|
  s.name                    = 'StartAppSDK'
  s.version                 = '4.9.2'
  s.summary                 = 'StartApp SDK for mobile advertising'

  s.description             = <<-DESC
                              'StartApp In-App Ads enables you to reap the benefits of StartApp's In-App monetization products, which maximize the revenue generated by your application. All this profit-making is achieved with minimal effort and minimal interference with your users’ experience.'
                                DESC
                       
  s.platform                = :ios
  s.ios.deployment_target   = '9.0'
  s.homepage                = 'https://support.start.io/hc/en-us/articles/360006012653-IOS-Standard'
  s.license                 = { :type => 'Commercial', :file => 'LICENSE' }
  s.author                  = { 'StartApp' => 'support@startapp.com' }
  s.source                  = { :git => 'https://github.com/StartApp-SDK/StartAppSDK.git', :tag => s.version.to_s }
  
  s.ios.vendored_frameworks = 'StartApp.xcframework'
  s.frameworks              =
                            'AdSupport',
                            'AppTrackingTransparency',
                            'AVFoundation',
                            'CoreAudio',
                            'CoreFoundation',
                            'CoreGraphics',
                            'CoreMedia',
                            'CoreTelephony',
                            'Foundation',
                            'JavaScriptCore',
                            'NetworkExtension',
                            'QuartzCore',
                            'StoreKit',
                            'SystemConfiguration',
                            'UIKit',
                            'WebKit'
  s.libraries               = 'z'

end
