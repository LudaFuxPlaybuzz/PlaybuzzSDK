//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import PlaybuzzSDK
import MessageUI

class ViewController: UIViewController, PlaybuzzQuizProtocol, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{
    
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
    
    // MARK: - PlaybuzzQuizProtocol
    func resizePlaybuzzContainer(_ height: CGFloat)
    {
        playbuzzQuizHeight.constant = height
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate
    func presentShareViewController(_ viewController:UIViewController)
    {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}

