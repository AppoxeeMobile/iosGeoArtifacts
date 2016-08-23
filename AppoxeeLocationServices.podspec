Pod::Spec.new do |s|

  s.name         = "AppoxeeLocationServices"
  s.version      = "4.0.14"
  s.summary      = "AppoxeeLocationServices enables developers to harnest the full power of Appoxee Location Services on their iOS applications."
  s.description  = 	<<-DESC
  					AppoxeeLocationServices enables geo capebilities in your iOS application, for engaging your application users and increasing retention.
                   	DESC
  s.homepage     = "http://www.appoxee.com"
  s.license      = { :type => "Custom", :file => "AppoxeeLicence.txt" }
  s.author       = { "Appoxee" => "info@appoxee.com" }
  s.source       = { :git => "https://github.com/AppoxeeMobile/iosGeoArtifacts.git", :tag => "4.0.14" }
  s.platform     = :ios, "7.0"
  s.ios.framework = 'CoreLocation'
  s.ios.vendored_frameworks = "SDK/AppoxeeLocationServices.framework"
  s.preserve_paths = 'SDK/AppoxeeLocationServices.framework'
  s.dependency 'AppoxeeSDK', '~> 4.0.14'
  s.requires_arc = true

end
