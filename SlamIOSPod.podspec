Pod::Spec.new do |s|
    s.name             = 'SlamIOSPod'
    s.version          = '1.0.0'
    s.summary          = 'Swift Closure based open source UI Framework for iOS Development.'
    s.description      = <<-DESC
    Target/Actions, Delegates, Data Sources and even Subclassing are all traditional elements under Objected Oriented programming for iOS & Mac OS.  While they will never be replaced, there are times when such patterns are cumbersome and time-consuming. An alternative methodology is to use Closures to change or expand the functionality of elements.  Slam is a user interface Framework for iOS/Mac that provides basic views that follow this pattern. The majority of the Classes in the Slam Framework are subclasses for classic iOS user interface elements, modified to support closures.  For example, SlamButton is a subclass of UIButton, that invokes it's property closure pressActionBlock when the button is pressed, instead of executing a target action. Similarly, the button's visible and enabled states are updated using closures that return Boolean flags to indicate their states (visibleDataSource and enableDataSource).
    DESC
    
    s.name             = 'SlamIOSPod'
    s.homepage         = 'https://github.com/magesteve/SlamIOSPod'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Steve Sheets' => 'magesteve@mac.com' }
    s.source           = { :git => 'https://github.com/magesteve/SlamIOSPod.git', :tag =>     s.version.to_s }
    s.social_media_url = 'https://twitter.com/magesteve'
    
    s.ios.deployment_target = '11.0'
    s.source_files = 'SlamIOSPod/Classes/*.swift'
    s.frameworks = 'UIKit'
    s.swift_version = '5.0'
end
