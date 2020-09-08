Pod::Spec.new do |s|

  s.name            = 'JFMarkSlider'
  s.version         = '0.0.1'
  s.summary         = 'A UISlider with mark and slide with mark'

  s.homepage        = 'https://github.com/hxwxww/JFMarkSlider'
  s.license         = 'MIT'

  s.author          = { 'hxwxww' => 'hxwxww@163.com' }
  s.platform        = :ios, '9.0'
  s.swift_version   = '5.0'

  s.source          = { :git => 'https://github.com/hxwxww/JFMarkSlider.git', :tag => s.version }

  s.source_files    = 'JFMarkSlider/JFMarkSlider/*.swift'

  s.frameworks      = 'Foundation', 'UIKit'

end
