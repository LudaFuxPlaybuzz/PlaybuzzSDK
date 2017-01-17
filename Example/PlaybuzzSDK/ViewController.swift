//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

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
        let companyDomain = "http://www.example.com"
        
        playbuzzQuiz.reloadItem(itemAlias,
                                companyDomain: companyDomain,
                                showItemInfo: true)
    }
    
    func resizePlaybuzzContainer(_ height: CGFloat)
    {
        playbuzzQuizHeight.constant = height
    }
    
    func presentShareViewController(_ viewController:UIViewController)
    {
        self.present(viewController, animated: true, completion: nil)
    }
}

