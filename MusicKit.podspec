Pod::Spec.new do |spec|
  spec.name         = 'MusicKit'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/benzguo/MusicKit'
  spec.authors      = { 'Ben Guo' => 'benzguo@gmail.com' }
  spec.summary      = 'A framework for composing and transforming music in Swift'
  spec.source       = { :git => 'https://github.com/benzguo/MusicKit.git', :tag => '0.1.0' }
  spec.source_files = 'MusicKit/*.{h, m, swift}'
end