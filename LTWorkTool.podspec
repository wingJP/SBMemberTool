#
# Be sure to run `pod lib lint LTWorkTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 名称 使用的时候pod search [name]
  s.name             = 'LTWorkTool'
  # 代码库的版本
  s.version          = '0.0.3'
  # 简介
  s.summary          = '通用工具'

  # swift 版本号
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        乐特--通用工具
                       DESC
  # 主页
  s.homepage         = 'https://gitee.com/xiaoyigegespec/LTWorkTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # 许可证书类型，要和仓库的LICENSE 的类型一致
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 作者名称 和 邮箱
  s.author           = { '小毅' => '1030129479@qq.com' }
  #代码的Clone 地址 和 tag 版本
  s.source           = { :git => 'https://gitee.com/xiaoyigegespec/LTWorkTool.git', :tag => s.version.to_s }
  # 作者主页
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  # 代码库最低支持的版本
  s.platform = :ios, "10.0"

  # 如果使用pod 需要导入哪些资源
  s.source_files = 'LTWorkTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LTWorkTool' => ['LTWorkTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit'
  
end
