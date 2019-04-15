Pod::Spec.new do |s|
    s.name             = 'SlamIOSPod'
    s.version          = '0.1.0'
    s.summary          = 'Swift Closure based open source UI Framework for iOS Development.'
    s.description      = <<-DESC
    Target/Actions, Delegates, Data Sources and even Subclassing are all traditional elements under Objected Oriented programming for iOS & Mac OS.  While they will never be replaced, there are often times when such patterns are cumbersome and time consuming. A simplier methology is to use Closures to change or expand the functionality of elements. Slam is a user interface Framework for iOS/Mac that provides basic views that provide this option. Instead of Targe/Actions, buttons & switches have the property actionClosure, which is invoked when the field is clicked on.  Instead of Data Sources that provide information regarding cells for a TableViews, closure provied this information.
    DESC
    
    s.name             = 'SlamIOSPod'
    s.homepage         = 'https://github.com/magesteve/SlamIOSPod'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Steve Sheets' => 'magesteve@mac.com' }
    s.source           = { :git => 'https://github.com/magesteve/SlamIOSPod.git', :tag =>     s.version.to_s }
    s.social_media_url = 'https://twitter.com/magesteve'
    
    s.ios.deployment_target = '8.0'
    s.source_files = 'SlamIOSPod/Classes/*.swift'
    s.frameworks = 'UIKit'
    s.swift_version = '5.0'
end
