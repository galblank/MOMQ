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
  s.source       = { :git => "https://github.com/galblank/eventbussdk.git", :commit => "0d6761feefccff1f7d8b7c7788ceb8e9cd1314ea" }
 #non_arc_files		= "eventbussdk/Helpers/RegexKitLite.{h,m}"
  s.preserve_paths = '**'
#s.module_map = 'eventbussdk/sqlite3/module.modulemap'
  s.default_subspec  = 'standard'
  s.subspec 'standard' do |ss|
    ss.ios.frameworks = 'CoreFoundation','ExternalAccessory','Security'
    ss.source_files = 'eventbussdk/**/*.{c,h,m,swift}'
    ss.library = 'icucore','sqlite3'
    ss.dependency 'sqlite3'
    ss.exclude_files = "**/*.{png}","**/*.{pdf}"
    ss.preserve_paths = 'eventbussdk/sqlite3/**/*'
    ss.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/eventbussdk/sqlite3'
    }
    
  end


end
