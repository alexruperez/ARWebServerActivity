Pod::Spec.new do |s|
  s.name         = 'ARWebServerActivity'
  s.version      = '1.0.2'
  s.license      = 'MIT'
  s.summary      = 'A UIActivity subclass that share files via GCDWebServer with Twitter Bootstrap UI.'
  s.homepage     = 'https://github.com/alexruperez/ARWebServerActivity'
  s.screenshots  = "https://raw.githubusercontent.com/alexruperez/ARWebServerActivity/master/screenshot.png"
  s.author       = { "Alex Rupérez" => "contact@alexruperez.com" }
  s.social_media_url   = "http://twitter.com/alexruperez"
  s.platform     = :ios, '6.0'
  s.source       = { :git => 'https://github.com/alexruperez/ARWebServerActivity.git', :tag => s.version.to_s }
  s.source_files = 'ARWebServerActivity/*.{h,m,swift}'
  s.resources    = 'ARWebServerActivity/ARWebServerActivity.bundle'
  s.requires_arc = true
  s.frameworks = "UIKit", "CoreGraphics"
  s.dependency 'GCDWebServer/WebUploader', '~> 3.3'
end
