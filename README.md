![playbuzz logo](http://i68.tinypic.com/55o84j.png)

[![CI Status](http://img.shields.io/travis/Luda Fux/PlaybuzzSDK.svg?style=flat)](https://travis-ci.org/Luda Fux/PlaybuzzSDK)
[![Version](https://img.shields.io/cocoapods/v/PlaybuzzSDK.svg?style=flat)](http://cocoapods.org/pods/PlaybuzzSDK)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://github.com/orazz/CreditCardForm-iOS/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />

## Get Started

The Playbuzz SDK helps app developers embed Playbuzz games in thier native apps. This guide shows you how to create a new iOS project, include the Playbuzz SDK, and add your first Playbuzz game.

## Prerequisites

- Xcode 7.0 or higher
- An iOS 7.0 or higher deployment target
- A valid Xcode project
- Installation of [CocoaPods](http://cocoapods.org) for dependency management

## Example

To run the example project:
1. Donwload the repo
2. Run `pod install` from the Example directory.
3. Run the project

## Installation

### Add Playbuzz SDK using CocoaPods

**Create the Podfile**

In the same directory as YourProject.xcodeproj file, create a file named Podfile that includes the following:

```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'

target 'YourProject' do
   pod 'PlaybuzzSDK'
end
```

**Run pod install**

Run pod install from the terminal, in the same directory as the Podfile. Once the installation finishes, close BannerExample.xcodeproj and open up BannerExample.xcworkspace. Your project files should include a Pods project with new dependencies for Firebase and AdMob.

PlaybuzzSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


###Rebuild and run your project. 
The app still shows a white screen, but now the Playbuzz SDK is being referenced in your app.

### Enable **Allow Arbitrary Loads** in **App Transport Security Settings** in your Info.plist
![plist](http://i68.tinypic.com/286wzet.png)

### Add a PlaybuzzQuiz in storyboard

## Author

Luda Fux, luda@playbuzz.com

## License

PlaybuzzSDK is available under the MIT license. See the LICENSE file for more info.
