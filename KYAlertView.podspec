Pod::Spec.new do |s|
s.name         = "KYAlertView"
s.summary      = "A highly customized package of AlertView, strong scalability."
s.version      = '0.0.2'
s.homepage     = "https://github.com/kingly09/KYAlertView"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "kingly" => "libintm@163.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/kingly09/KYAlertView.git", :tag => s.version.to_s }
s.social_media_url   = "https://github.com/kingly09"
s.source_files = 'KYAlertViewLib/*.{h,m}'
s.framework    = "UIKit"
s.requires_arc = true
end
