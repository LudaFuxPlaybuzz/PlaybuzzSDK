![playbuzz logo](http://i68.tinypic.com/55o84j.png)

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

## Instalation 

1) Add Playbuzz SDK using CocoaPods 

```
pod 'PlaybuzzSDK'
```

2) Enable html loads in the plist
 Enable **Allow Arbitrary Loads** in **App Transport Security Settings** in your Info.plist

![plist](http://i67.tinypic.com/10hlwn8.png)

## Usage

1. Add import PlaybuzzSDK to ViewController.swift so the compiler knows that PlaybuzzView is a valid class.
2. Create PlaybuzzView with appropriate frame
3. Load PlaybuzzView with embedCode and your company domain
4. Add PlaybuzzView to your view

**ViewController.swift**

```Swift
import UIKit
import PlaybuzzSDK

class ViewController: UIViewController{
    
    override func viewDidLoad()
    {
        super.viewDidLoad() 

        let embedCode = "<script type=\"text/javascript\" src=\"//cdn.playbuzz.com/widget/feed.js\"></script><div class=\"pb_feed\" data-embed-by=\"bcf88815-8496-421d-89ad-76793fdcd387\" data-item=\"7885f470-9bf5-468b-8eff-1c1ac7f7738a\" ></div>"
        
        let companyDomain = "http://www.example.com"
        
        let playbuzzView = PlaybuzzView.init(frame: self.view.frame)
        
        playbuzzView.loadItem(embedCode,
                              companyDomain: companyDomain,
                              showItemInfo: true)
                              
        self.view.addSubview(playbuzzView)
    }
}


```

## Congratulations! 

**You've embedded you're first Playbuzz quiz**

![screenshot](http://i65.tinypic.com/r10wev.png)

## License

PlaybuzzSDK is available under the MIT license. See the LICENSE file for more info.
