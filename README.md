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

- To check out example, download the repo, open PlaybuzzSDK.xcworkspace and run the project.

## Installation

1) Add Playbuzz SDK using [CocoaPods](http://cocoapods.org) 

```
pod 'PlaybuzzSDK'
```

2) Enable html loads in the plist
 Enable **Allow Arbitrary Loads** in **App Transport Security Settings** in your Info.plist
![plist](http://i67.tinypic.com/10hlwn8.png)

## Usage

1) Drag a **UIView** into **UIScrollView** in your view controller. Then in the Custom Class section in the top-right corner, select the custom class **PlaybuzzQuiz** as the Class for this view (make sure the module is **PlaybuzzSDK**)

![view](http://i66.tinypic.com/20rskl3.png)

2) Add constraints on the PlaybuzzSDK so it would properly fit your views

3) Adding a reference to your PlaybuzzQuiz in code

![referance](http://i66.tinypic.com/elbp8z.png)
![referance](http://i68.tinypic.com/210mwc5.png)

4) To resolve a compilation error, add **import PlaybuzzSDK** to ViewController.swift so the compiler knows that PlaybuzzQuiz is a valid class.

5) Adding a reference to playbuzzQuiz height constaraint 

![height](http://i68.tinypic.com/211jwhz.png)
![height](http://i63.tinypic.com/jigmsl.png)

6) Load the quiz with your preferable configuration

You'll need **itemAlies** - the url suffix of your item 

![url](http://i63.tinypic.com/1z35k7b.png)

**ViewController.swift**

```Swift
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let companyDomain = "http://www.youCompony.com"
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
        
        playbuzzQuiz.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: true,
                                showShareButton: true,
                                showFacebookComments: true,
                                showItemInfo: true,
                                companyDomain: companyDomain)
    } 
}
```
1. **companyDomain** - the domain configered for your compony 
2. **userID** - uniq identifier for every device 
3. **itemAlies** - the url suffix of your item 

7) Update quiz height

**Conform to PlaybuzzQuizProtocol**

```Swift
class ViewController: UIViewController, PlaybuzzQuizProtocol
```

and implemt the following function:
```Swift
func resizePlaybuzzContainer(_ height: CGFloat)
{
    playbuzzQuizHeight.constant = height
}
```
### Build and run the app
![finished](http://i65.tinypic.com/f4phya.png)

Congratulations, you've successfully made your first PlaybuzzQuiz!

## The finished code

```Swift
import UIKit
import PlaybuzzSDK

class ViewController: UIViewController, PlaybuzzQuizProtocol{
    
    @IBOutlet weak var playbuzzQuiz: PlaybuzzQuiz!
    @IBOutlet weak var playbuzzQuizHeight: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.playbuzzQuiz.delegate = self
     
        let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
        let companyDomain = "http://www.playbuzz.com"
        let userID = UIDevice.current.identifierForVendor!.uuidString
        
        playbuzzQuiz.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: true,
                                showShareButton: true,
                                showFacebookComments: true,
                                showItemInfo: true,
                                companyDomain: companyDomain)
    }
    
    func resizePlaybuzzContainer(_ height: CGFloat)
    {
        playbuzzQuizHeight.constant = height
    }
}
```

## Author

Luda Fux, luda@playbuzz.com

## License

PlaybuzzSDK is available under the MIT license. See the LICENSE file for more info.
