![playbuzz logo](http://i68.tinypic.com/55o84j.png)

[![Version](https://img.shields.io/cocoapods/v/PlaybuzzSDK.svg)](http://cocoapods.org/pods/PlaybuzzSDK)
[![Support](https://img.shields.io/badge/contact-LudaFux-brightgreen.svg)](mailto:luda@playbuzz.com)
[![Swift 3 compatible](https://img.shields.io/badge/language-Swift-yellowgreen.svg)](https://developer.apple.com/swift)
![Platform iOS](https://img.shields.io/badge/platform-iOS-yellow.svg)
[![License: MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/orazz/CreditCardForm-iOS/blob/master/LICENSE)


## Get Started

The Playbuzz SDK enabled developers easily embed Playbuzz items in native apps.

## Prerequisites

- Xcode 8
- iOS 9.0+
- Installation of [CocoaPods](http://cocoapods.org). ([Tutorial](https://www.raywenderlich.com/97014/use-cocoapods-with-swift) for beginners)

## Example

To check out the example, download the repo run the sample project.

## Usage

1) Add Playbuzz SDK using CocoaPods 

```
pod 'PlaybuzzSDK'
```

2) Add import PlaybuzzSDK to ViewController.swift so the compiler knows that PlaybuzzView is a valid class.
```Swift 
import PlaybuzzSDK
```

3) Load PlaybuzzView with embedCode and youCompanyDomain

**ViewController.swift**

```Swift
import UIKit
import PlaybuzzSDK

class ViewController: UIViewController{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
        let companyDomain = "http://www.example.com"
        
        let playbuzzView = PlaybuzzView.init(frame: self.view.frame)
        
        playbuzzView.reloadItem(itemAlias,
                                companyDomain: companyDomain,
                                showItemInfo: true)
        self.view.addSubview(playbuzzView)
    }
}


```
1. **companyDomain** - the domain configered for your compony 
2. **itemAlies** - the url suffix of your item 
3. **showItemInfo** - show or hide item title and description

4) Enable html loads in the plist
 Enable **Allow Arbitrary Loads** in **App Transport Security Settings** in your Info.plist
![plist](http://i67.tinypic.com/10hlwn8.png)

### Build and run the app
![finished](http://i65.tinypic.com/f4phya.png)

Congratulations, you've successfully made your first PlaybuzzView!

## License

PlaybuzzSDK is available under the MIT license. See the LICENSE file for more info.
