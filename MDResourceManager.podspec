
Pod::Spec.new do |s|
  s.name             = "MDResourceManager"
  s.version          = "0.1.0"
  s.summary          = "iOS Resource Management, the Android way"
  s.description      = <<-DESC
                       Provide resources independently of your code. Manage different sizes, strings depending on the device type or orientation.
                       * Inspired in the Resource management of Android.
                       * Easily extended, you can provide your own criterias. e.g. handle different values depending on your product jurisdictions.
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/MDResourceManager"
  s.license          = 'MIT'
  s.author           = { "Joao Prudencio" => "joao.prudencio@mindera.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/MDResourceManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.subspec 'Manager' do |ss|
    ss.source_files = 'Pod/Classes/Manager'
  end

  s.subspec 'Filter' do |ss|
    ss.source_files = 'Pod/Classes/Filter'
    ss.dependency 'MDResourceManager/Criteria'
    ss.dependency 'MDResourceManager/Resource'
  end

  s.subspec 'Criteria' do |ss|
    ss.source_files = 'Pod/Classes/Criteria'
    ss.dependency 'MDResourceManager/Util'
  end

  s.subspec 'Resource' do |ss|
    ss.source_files = 'Pod/Classes/Resource'
  end

  s.subspec 'Parser' do |ss|
    ss.source_files = 'Pod/Classes/Parser'
    ss.dependency 'MDResourceManager/Criteria'
    ss.dependency 'MDResourceManager/Resource'
  end

  s.subspec 'Util' do |ss|
    ss.source_files = 'Pod/Classes/Util'
  end

end
