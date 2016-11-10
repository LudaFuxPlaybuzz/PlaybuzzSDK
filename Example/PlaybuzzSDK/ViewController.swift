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
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var viewsContainer: UIView!
    
    let playbuzzQuiz = PlaybuzzQuiz(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playbuzzQuiz.delegate = self
        self.reloadItem()
        viewsContainer.addSubview(playbuzzQuiz)
    }
    
    func reloadItem()
    {
        
        let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let companyDomain = "http://www.playbuzz.com"
        
        let showRecommendations = true
        let showShareButton = true
        let showFacebookComments = true
        let showItemInfo = true
        
        playbuzzQuiz.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: showRecommendations,
                                showShareButton: showShareButton,
                                showFacebookComments: showFacebookComments,
                                showItemInfo: showItemInfo,
                                companyDomain: companyDomain)
    }
    
    //MARK: PlaybuzzWebView Protocol
    func resizePlaybuzzContainer(_ height: CGFloat){
        containerHeight.constant = height
    }
}

