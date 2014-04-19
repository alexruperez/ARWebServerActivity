Pod::Spec.new do |spec|
  spec.name         = 'ARWebServerActivity'
  spec.version      = '0.0.1'
  spec.license      = 'MIT'
  spec.summary      = 'A UIActivity subclass that share files via GCDWebServer with Twitter Bootstrap UI.'
  spec.homepage     = 'https://github.com/alexruperez/ARWebServerActivity'
  spec.author       = 'Alex Ruperez'
  spec.platform     = :ios, '6.0'
  spec.source       = { :git => 'https://github.com/alexruperez/ARWebServerActivity.git', :tag => 'v0.0.1' }
  spec.source_files = 'ARWebServerActivity/*.{h,m}'
  spec.resources    = 'ARWebServerActivity/ARWebServerActivity.bundle'
  spec.requires_arc = true
end
