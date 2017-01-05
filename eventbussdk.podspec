#
#  Be sure to run `pod spec lint eventbus.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "eventbussdk"
  s.version      = "0.1.2"
  s.summary      = "mobile foundation framework"
  s.resources        = 'README.md'
  s.social_media_url = 'https://twitter.com/galblank'
  s.platform     = :ios, '9.1'
  s.requires_arc = true
  s.description  = "brings to provide ALL the foundational needs of any mobile applicaion"
  s.homepage     = "https://github.com/galblank/eventbussdk"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author             = { "Blank, Gal" => "galblank@gmail.com" }
  s.source       = { :git => "https://github.com/galblank/eventbussdk.git", :commit => "275cc9a8e2177404ae900c87426a3f6c1d03a167" }
  s.preserve_paths = 'eventbussdk/**'
  s.source_files = 'eventbussdk/**/*.{c,h,m,swift}'
  s.library = 'icucore','sqlite3'
  s.pod_target_xcconfig = {
   'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/eventbussdk/sqlite3'
  }
end
