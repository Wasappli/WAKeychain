Pod::Spec.new do |s|
  s.name         = "WAKeychain"
  s.version      = "1.0.0"
  s.summary      = "A wrapper on top of SSKeychain which keeps the values in RAM"
  s.homepage     = "https://github.com/Wasappli/WAKeychain"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Marian Paul" => "marian@wasapp.li" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Wasappli/WAKeychain.git", :tag => "1.0.0" }
  s.source_files = "Files/*.{h,m}"
  s.requires_arc = true
  s.dependency   "SSKeychain"

end
