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
    
    //MARK: - IBOutlets
    @IBOutlet weak var playbuzzQuiz: PlaybuzzQuiz!
    @IBOutlet weak var playbuzzQuizHeight: NSLayoutConstraint!
    
    //MARK: - Parameters for PlaybuzzQuiz
    let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
    let companyDomain = "http://www.playbuzz.com"
    let userID = UIDevice.current.identifierForVendor!.uuidString
    let showRecommendations = true
    let showShareButton = true
    let showFacebookComments = true
    let showItemInfo = true
    
    //MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playbuzzQuiz.delegate = self
        self.reloadItem()
    }
    
    //MARK: - PlaybuzzQuiz
    func reloadItem()
    {
        playbuzzQuiz.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: showRecommendations,
                                showShareButton: showShareButton,
                                showFacebookComments: showFacebookComments,
                                showItemInfo: showItemInfo,
                                companyDomain: companyDomain)
    }
    
    //MARK: - PlaybuzzQuizProtocol Protocol
    func resizePlaybuzzContainer(_ height: CGFloat)
    {
        playbuzzQuizHeight.constant = height
    }
}

