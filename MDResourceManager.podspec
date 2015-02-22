#
# Be sure to run `pod lib lint MDResourceManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MDResourceManager"
  s.version          = "0.1.0"
  s.summary          = "A short description of MDResourceManager."
  s.description      = <<-DESC
                       An optional longer description of MDResourceManager

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
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
