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

        let embedCode = "<script type=\"text/javascript\" src=\"//cdn.playbuzz.com/widget/feed.js\"></script><div class=\"pb_feed\" data-embed-by=\"bcf88815-8496-421d-89ad-76793fdcd387\" data-item=\"7885f470-9bf5-468b-8eff-1c1ac7f7738a\" ></div>"
        let companyDomain = "http://www.example.com"
        
        let playbuzzView = PlaybuzzView.init(frame: self.view.frame)
        
        playbuzzView.loadItem(embedCode,
                              companyDomain: companyDomain,
                              showItemInfo: true)
        self.view.addSubview(playbuzzView)
    }
}

