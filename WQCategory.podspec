
Pod::Spec.new do |s|

s.name         = "WQCategory"
s.version      = "0.0.2"
s.summary      = "iOS所有项目通用的分类的工具文件"
s.homepage     = "https://github.com/WQiOS/WQCategory"
s.license      = "MIT"
s.author       = { "王强" => "1570375769@qq.com" }
s.platform     = :ios, "8.0" #平台及支持的最低版本
s.requires_arc = true # 是否启用ARC
s.source       = { :git => "https://github.com/WQiOS/WQCategory.git", :tag => "#{s.version}" }
s.source_files  = "WQCategory/*.{h,m}"
s.frameworks = 'UIKit', 'CoreText'

end
