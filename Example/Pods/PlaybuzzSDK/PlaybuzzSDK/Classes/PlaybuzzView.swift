//
//  PlaybuzzView.swift
//  Pods
//
//  Created by Luda Fux on 11/9/16.
//
//

import UIKit
import WebKit

public class PlaybuzzView: UIView, WKScriptMessageHandler
{
    
    var webView: WKWebView!
    public weak var delegate: PlaybuzzViewProtocol?
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addBehavior()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        addBehavior()
    }
    
    func addBehavior ()
    {
        let contentController = WKUserContentController();
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        configuration.allowsInlineMediaPlayback = true
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        webView.configuration.userContentController.add(self,name: "callbackHandler")
        self.addSubview(webView)
    }
    
    public func loadItem(_ embedCode:String,
                           companyDomain: String,
                           showItemInfo:Bool)
    {
        if webView.isLoading {
            webView.stopLoading()
        }
        
        var embedStringForMobile = String()
        
        let userID = UIDevice.current.identifierForVendor!.uuidString
        
        if let itemID = PlaybuzzEmbedParser.parseEmbedToGetItemID(embedCode)
        {
            embedStringForMobile = PlaybuzzEmbedParser.embedStringWithItemID(itemID,
                                                              companyDomain: companyDomain,
                                                              showItemInfo: showItemInfo,
                                                              userID: userID)
            
//            PlaybuzzAnalyticsManager.sendAnaliticsWithItemID(itemID, companyDomain:companyDomain)
        }
        else if let itemAlies = PlaybuzzEmbedParser.parseEmbedToGetItemAlies(embedCode)
        {
            embedStringForMobile = PlaybuzzEmbedParser.embedStringWithAlies(itemAlies,
                                                              companyDomain: companyDomain,
                                                              showItemInfo: showItemInfo,
                                                              userID: userID)
            
//            PlaybuzzAnalyticsManager.sendAnaliticsWithItemAlies(itemAlies, companyDomain:companyDomain)
        }
        
        webView.loadHTMLString(embedStringForMobile, baseURL: URL(string:companyDomain))
        
    }
        
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "contentSize"
        {
            self.updatePageViewsFrames()
        }
    }
    
    func updatePageViewsFrames()
    {
        webView.sizeToFit()
        let webViewContentHeight:CGFloat = webView.scrollView.contentSize.height
        self.delegate?.resizePlaybuzzContainer(webViewContentHeight)
        
    }
    
    public func prepareForReuse() -> Void
    {
        self.webView.loadHTMLString("", baseURL: nil)
    }
    
    public func userContentController(_ userContentController: WKUserContentController,didReceive message: WKScriptMessage)
    {
        
    }
}


// MARK: - EmbededWebViewControllerProtocol
public protocol PlaybuzzViewProtocol: class
{
    func resizePlaybuzzContainer(_ height: CGFloat)
}
