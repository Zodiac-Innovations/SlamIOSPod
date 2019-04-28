# SlamIOSPod

[![CI Status](https://img.shields.io/travis/magesteve/SlamIOSPod.svg?style=flat)](https://travis-ci.org/magesteve/SlamIOSPod)
[![Version](https://img.shields.io/cocoapods/v/SlamIOSPod.svg?style=flat)](https://cocoapods.org/pods/SlamIOSPod)
[![License](https://img.shields.io/cocoapods/l/SlamIOSPod.svg?style=flat)](https://cocoapods.org/pods/SlamIOSPod)
[![Platform](https://img.shields.io/cocoapods/p/SlamIOSPod.svg?style=flat)](https://cocoapods.org/pods/SlamIOSPod)

## Description

Target/Actions, Delegates, Data Sources and even Subclassing are all traditional elements under Objected Oriented programming for iOS & Mac OS.  While they will never be replaced, there are times when such patterns are cumbersome and time-consuming. An alternative methodology is to use Closures to change or expand the functionality of elements. 

Slam is a user interface Framework for iOS/Mac that provides basic views that follow this pattern. The majority of the Classes in the Slam Framework are subclasses for classic iOS user interface elements, modified to support closures.  For example, SlamButton is a subclass of UIButton, that invokes it's property closure pressActionBlock when the button is pressed, instead of executing a target action. Similarly, the button's visible and enabled states are updated using closures that return Boolean flags to indicate their states (visibleDataSource and enableDataSource). 

## Documentation

All public classes, protocols, properties & functions have inline documentation (DOxygen style).  Further explanation of the Framework, refer to the SlamIOSPod-Documentation.md file.

## Requirements

SlamIOSPod is targeted for the last versions of iOS and the Swift programming languages.

## Installation

SlamIOSPod is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SlamIOSPod'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

### Steve Sheets, magesteve@mac.com

Originally from Silicon Valley, Steve has been embedded in the software industry for over 35 years. As an expert in user interface and design, he started developer desktop applications for companies like Apple and AOL, moved into mobile development, and is now working in the virtual reality and Augment Reality space.  He has taught Objective-C & Swift development classes (MoDev, Learning Tree), as well as given talk on variety of developer topics (DC Mac Dev group, Capital One Swift Conference).  He is an avid game player, swordsman and an occasional game designer

## License

SlamIOSPod is available under the MIT license. See the LICENSE file for more info.
