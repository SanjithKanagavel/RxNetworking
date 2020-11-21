Pod::Spec.new do |s|
  s.name             = 'RxNetworking'
  s.version          = '0.0.2'
  s.summary          = 'iOS Networking library using RxSwift'
  s.homepage         = 'https://github.com/SanjithKanagavel/RxNetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SanjithKanagavel' => 'sanjithkanagavel@gmail.com' }
  s.source           = { :git => 'https://github.com/SanjithKanagavel/RxNetworking.git', :tag => 'v'+s.version.to_s }
  s.social_media_url = 'https://twitter.com/Dastan__17'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = 'RxNetworking/Classes/*.swift'
  s.dependency 'RxSwift', '>= 5.0.0'
end
