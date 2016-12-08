![playbuzz logo](http://i68.tinypic.com/55o84j.png)

[![Version](https://img.shields.io/cocoapods/v/PlaybuzzSDK.svg)](http://cocoapods.org/pods/PlaybuzzSDK)
[![Support](https://img.shields.io/badge/contact-LudaFux-brightgreen.svg)](mailto:luda@playbuzz.com)
[![CI Status](http://img.shields.io/travis/Luda Fux/PlaybuzzSDK.svg)](https://travis-ci.org/Luda Fux/PlaybuzzSDK)
[![Swift 3 compatible](https://img.shields.io/badge/language-Swift-yellowgreen.svg)](https://developer.apple.com/swift)
![Platform iOS](https://img.shields.io/badge/platform-iOS-yellow.svg)
[![License: MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/orazz/CreditCardForm-iOS/blob/master/LICENSE)


## Get Started

The Playbuzz SDK enabled developers easily embed Playbuzz games in native apps.

## Prerequisites

- Xcode 8
- iOS 9.0+
- Installation of [CocoaPods](http://cocoapods.org)

## Example

To check out example, download the repo, open PlaybuzzSDK.xcworkspace and run the project.

## Installation

**Add Playbuzz SDK using CocoaPods** 

Create the Podfile

In the same directory as YourProject.xcodeproj file, create a file named Podfile that includes the following:

```
use_frameworks!

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
