
Pod::Spec.new do |s|

s.name             = "IMSegmentPageView"
s.version          = "1.0.2"
s.summary          = "A segment titleView and pageView menu"

s.description      = "IMSegmentPageView is a Swift library that provides a customizable segment titleView and pageView menu"

s.homepage         = "https://github.com/iMazy/IMSegmentPageView"

s.license          = "MIT"

s.author           = { "Mazy" => "mazy_ios@163.com" }

s.platform         = :ios, "9.0"

s.source           = { :git => "https://github.com/iMazy/IMSegmentPageView.git", :tag => "#{s.version}" }

s.source_files     = "IMSegmentPageView/IMSegmentPageViewLib/*"

s.swift_version    = '4.2'

s.framework        = "UIKit"

s.requires_arc     = true

end

