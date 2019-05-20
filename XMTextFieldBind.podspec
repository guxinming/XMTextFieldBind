#
#  Be sure to run `pod spec lint XMTextFieldBind.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "XMTextFieldBind"
  spec.version      = "0.0.7"
  spec.summary      = "wo jiu ce shi yi xia"
  spec.description  = "wo jiu ce shi yi xia a"

  spec.homepage     = "https://github.com/guxinming/"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "小明" => "email@address.com" }
  spec.platform     = :ios, "8.0"

  spec.source       = { :git => "https://github.com/guxinming/XMTextFieldBind.git", :tag => spec.version }

  spec.source_files  = "TextFieldBind/KVOPlugin.{h,m}"
  spec.frameworks = "UIKit", "Foundation"
  spec.requires_arc = true

end
