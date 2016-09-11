Pod::Spec.new do |s|

  s.name         = "AppoxeeLocationServices"
  s.version      = "4.1.0"
  s.summary      = "Appoxee Location Services enables developers to harnest the full power of Appoxee Location Services on their iOS applications."
  s.description  = 	<<-DESC
  					Appoxee Location Services enables geo capebilities in your iOS application, for engaging your application users and increasing retention.
                   	DESC
  s.homepage     = "http://www.appoxee.com"
  s.license      = { :type => "Custom", :file => "AppoxeeLicence.txt" }
  s.author       = { "Appoxee" => "info@appoxee.com" }
  s.source       = { :git => "https://github.com/AppoxeeMobile/iosGeoArtifacts.git", :tag => "4.1.0" }
  s.platform     = :ios, "8.0"
  s.ios.framework = 'CoreLocation'
  s.ios.library = 'sqlite3'
  s.ios.vendored_frameworks = "SDK/AppoxeeLocationServices.framework"
  s.preserve_paths = 'SDK/AppoxeeLocationServices.framework'
  s.dependency 'AppoxeeSDK', '~> 4.1.0'
  s.requires_arc = true

end
