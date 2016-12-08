![playbuzz logo](http://i68.tinypic.com/55o84j.png)

[![Version](https://img.shields.io/cocoapods/v/PlaybuzzSDK.svg)](http://cocoapods.org/pods/PlaybuzzSDK)
[![Support](https://img.shields.io/badge/contact-LudaFux-brightgreen.svg)](mailto:luda@playbuzz.com)
[![CI Status](http://img.shields.io/travis/Luda Fux/PlaybuzzSDK.svg)](https://travis-ci.org/Luda Fux/PlaybuzzSDK)
[![Swift 3 compatible](https://img.shields.io/badge/language-Swift-yellowgreen.svg)](https://developer.apple.com/swift)
![Platform iOS](https://img.shields.io/badge/platform-iOS-yellow.svg)
[![License: MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/orazz/CreditCardForm-iOS/blob/master/LICENSE)


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
