Pod::Spec.new do |spec|

  spec.name         = "startio-mopub-mediation"
  spec.version      = "1.0.0"
  spec.summary      = "Start.io <-> MoPub iOS Mediation Adapter."

  spec.description  = <<-DESC
  Using this adapter you will be able to intergate Start.io SDK via MoPub mediation
                   DESC

  spec.homepage     = "https://www.start.io"
  spec.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  spec.author       = { "iOS Dev" => "iosdev@startapp.com" }
  
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/StartApp-SDK/ios-mopub-mediation.git", :tag => spec.version.to_s }
  spec.source_files  = "StartioMopubMediation/**/*.{h,m}"
  # spec.public_header_files = "StartioMopubMediation/**/*.h"

  spec.frameworks = "Foundation", "UIKit"

  spec.requires_arc = true
  spec.static_framework = true

  spec.user_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES' } 
  # spec.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  spec.dependency "mopub-ios-sdk", "~> 5.16"
  spec.dependency "StartAppSDK", "~> 4.6.3"

end
