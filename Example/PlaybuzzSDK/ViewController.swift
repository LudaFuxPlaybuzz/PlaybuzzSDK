//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import PlaybuzzSDK

class ViewController: UIViewController, PlaybuzzWebViewProtocol, SettingsTableViewControllerProtocol{
    
    @IBOutlet weak var webViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var playbuzzView: PlaybuzzWebView!
    @IBOutlet weak var viewsContainer: UIView!
    
    static var showRecommendations = true
    static var showShareButton = true
    static var showFacebookComments = true
    static var showItemInfo = true
    
    let itemAlias = "shpaltman/10-best-commercials-for-the-olympic-games-rio-2016"
    let userID = UIDevice.current.identifierForVendor!.uuidString
    let companyDomain = "http://www.playbuzz.com"
    
//    let playbuzzQuiz = PlaybuzzQuiz(frame: CGRect(x: 20, y: 300, width: 400, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playbuzzView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadItem()
//        viewsContainer.addSubview(playbuzzQuiz)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        if let viewController = segue.destination as? SettingsTableViewController
        {
            viewController.delegate = self
        }
    }
    
    //MARK: PlaybuzzWebView Protocol
    func resizePlaybuzzContainer(_ height: CGFloat){
        webViewConstraint.constant = height
        containerHeight.constant = playbuzzView.frame.origin.y + height
    }
    
    func reloadItem()
    {
        playbuzzView.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: ViewController.showRecommendations,
                                showShareButton: ViewController.showShareButton,
                                showFacebookComments: ViewController.showFacebookComments,
                                showItemInfo: ViewController.showItemInfo,
                                companyDomain: companyDomain)
    }
}

