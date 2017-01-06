#
#  Be sure to run `pod spec lint eventbus.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "eventbussdk"
  s.version      = "0.1.3"
  s.summary      = "mobile foundation framework"
  s.resources        = 'README.md'
  s.social_media_url = 'https://twitter.com/galblank'
  s.platform     = :ios, '10.0'
  s.requires_arc = true
  s.description  = "brings to provide ALL the foundational needs of any mobile applicaion"
  s.homepage     = "https://github.com/galblank/eventbussdk"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author             = { "Blank, Gal" => "galblank@gmail.com" }
  s.source       = { :git => "https://github.com/galblank/eventbussdk.git", :commit => "4602f74fef70b784cedb15bbd0b09335ad03f065" }
  s.preserve_paths = '**'
  s.source_files = '**/*.{c,h,m,swift}'
  s.library = 'icucore','sqlite3'
  s.pod_target_xcconfig = {
   'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/eventbussdk/sqlite3'
  }

end
