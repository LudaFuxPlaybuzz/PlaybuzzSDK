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

        let embedCode = "<script type=\"text/javascript\" src=\"//cdn.playbuzz.com/widget/feed.js\"></script><div class=\"pb_feed\" data-embed-by=\"a1169349-e14e-44aa-b7de-6ba13538c4ec\" data-item=\"eb4ea8d9-4b0b-4bea-a5c8-769459871c4b\"></div>"
        
        let companyDomain = "http://www.example.com"
        
        let playbuzzView = PlaybuzzView.init(frame: self.view.frame)
        
        playbuzzView.loadItem(embedCode,
                              companyDomain: companyDomain,
                              showItemInfo: true)
        self.view.addSubview(playbuzzView)
    }
}

