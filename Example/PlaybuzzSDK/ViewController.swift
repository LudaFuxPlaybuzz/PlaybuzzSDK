//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

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

