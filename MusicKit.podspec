Pod::Spec.new do |s|
  s.name         = 'MusicKit'
  s.version      = '0.1.0'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/benzguo/MusicKit'
  s.authors      = { 'Ben Guo' => 'benzguo@gmail.com' }
  s.summary      = 'Swift music framework'
  s.description  = <<-DESC
                   A framework for composing and transforming musical abstractions in Swift.
                   DESC
  s.source       = { :git => 'https://github.com/benzguo/MusicKit.git', 
  				     :tag => "v#{s.version}" }
  s.source_files = 'MusicKit/*.{h, m, swift}'
end
