Pod::Spec.new do |s|
  s.name             = 'ALWCategories'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ALWCategories.'
  s.homepage         = 'https://github.com/ALongWay/ALWCategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lisong' => '370381830@qq.com' }
  s.source           = { :git => 'https://github.com/ALongWay/ALWCategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'ALWCategories/Classes/**/*'

end
