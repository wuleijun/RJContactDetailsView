#
#  Be sure to run `pod spec lint RJContactDetailsView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "RJContactDetailsView"
  s.version      = "0.0.1"
  s.summary      = "RJContactDetailsView is a beautiful view for displaying contact information including head image,name and phone numbers."
  s.homepage     = "https://github.com/wuleijun/RJContactDetailsView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "rayjune" => "wuleijun8@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/wuleijun/RJContactDetailsView.git", :tag => s.version.to_s }
  s.source_files  = "RJContactDetailsViews/*.{h,m}"
  s.requires_arc = true
end