//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import PlaybuzzSDK

class ViewController: UIViewController, PlaybuzzWebViewProtocol{
    
    @IBOutlet weak var webViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var playbuzzView: PlaybuzzWebView!
    @IBOutlet weak var viewsContainer: UIView!
    
    let playbuzzQuiz = PlaybuzzQuiz(frame: CGRect(x: 8, y: 300, width: 400, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playbuzzView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadItem()
//        viewsContainer.addSubview(playbuzzQuiz)
    }
    
    //MARK: PlaybuzzWebView Protocol
    func resizePlaybuzzContainer(_ height: CGFloat){
        webViewConstraint.constant = height
        containerHeight.constant = height
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
        
        playbuzzView.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: showRecommendations,
                                showShareButton: showShareButton,
                                showFacebookComments: showFacebookComments,
                                showItemInfo: showItemInfo,
                                companyDomain: companyDomain)
    }
}

