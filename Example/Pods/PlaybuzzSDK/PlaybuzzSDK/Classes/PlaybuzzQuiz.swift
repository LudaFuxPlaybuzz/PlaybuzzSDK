//
//  PlaybuzzQuiz.swift
//  Pods
//
//  Created by Luda Fux on 11/9/16.
//
//

import UIKit
import WebKit
import Social
import MessageUI

public class PlaybuzzQuiz: UIView, WKScriptMessageHandler{
    
    var webView: WKWebView!
    public weak var delegate: PlaybuzzQuizProtocol?
    var itemTitle = ""
    var itemURLString = ""
    
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
        webView.scrollView.isScrollEnabled = false
        self.addSubview(webView)
    }
    
    public func reloadItem(_ itemAlias:String,
                           companyDomain: String,
                           showItemInfo:Bool)
    {
        if webView.isLoading {
            webView.stopLoading()
        }
        let userID = UIDevice.current.identifierForVendor!.uuidString
        
        let embedTamplate = "<!DOCTYPE html><html><head> <meta content=\"width=device-width\" name=\"viewport\"> <style>.pb_iframe_bottom{display:none;}.pb_top_content_container{padding-bottom: 0 !important;}</style></head><body> <script type=\"text/javascript\">window.PlayBuzzCallback=function(event){var messageDict={\"event_name\":event.eventName,data:event.data};window.webkit.messageHandlers.callbackHandler.postMessage(messageDict)}</script> <script src=\"//cdn.playbuzz.com/widget/feed.js\" type=\"text/javascript\"> </script> <div class=\"pb_feed\" data-native-id=\"%@\" data-game=\"%@\" data-recommend=false data-shares=true data-comments=false data-game-info=\"%@\" data-platform=\"iPhone\" ></div></body></html>"
        
        let embedString: String = String(format: embedTamplate,
                                         userID,
                                         itemAlias,
                                         showItemInfo ? "true":"false")
        webView.loadHTMLString(embedString, baseURL: URL(string:companyDomain))
        self.getItemData(itemAlias, companyDomain:companyDomain)
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
        if let body = message.body as? AnyObject, let data = body["data"] as? NSDictionary, let shareTarget = data["articleSocialTarget"] as? String
        {
            print("\(shareTarget)")
            if shareTarget == "facebook" && SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let serviceSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                if let itemURL = URL(string: self.itemURLString)
                {
                    serviceSheet.add(itemURL)
                }
                serviceSheet.setInitialText(self.itemTitle)
                self.delegate?.presentShareViewController(serviceSheet)
            }
            else if shareTarget == "twitter" && SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                
                    let serviceSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    if let itemURL = URL(string: self.itemURLString)
                    {
                        serviceSheet.add(itemURL)
                    }
                    serviceSheet.setInitialText("\(self.itemTitle) @playbuzz")
                    self.delegate?.presentShareViewController(serviceSheet)
            }
            else if (shareTarget == "facebook" ||  shareTarget == "twitter")
            {
                let alert = UIAlertController(title: "Accounts", message: "Please login to your account to share.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.delegate?.presentShareViewController(alert)
            }
            else if (shareTarget == "sms")
            {
                if MFMessageComposeViewController.canSendText() {
                    let messageComposeVC = MFMessageComposeViewController()
                    
                    messageComposeVC.body = "I saw this on Playbuzz and couldn't wait to share it with you! http:\(self.itemURLString)"
                    messageComposeVC.messageComposeDelegate = self.delegate as! MFMessageComposeViewControllerDelegate?
                    self.delegate?.presentShareViewController(messageComposeVC)
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Your device doesn't support messaging", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.delegate?.presentShareViewController(alert)
                }
            }
            else
            {
                let url = URL(string: "fb://feed")!
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func getItemData(_ itemAlias:String,
                     companyDomain: String)
    {
        if let url = URL(string: "http://rest-api-v2.playbuzz.com/v2/items?itemAlias=\(itemAlias)")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("PlaybuzzSDK, getItemData: error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse
                {
                    if httpStatus.statusCode == 200
                    {
                        do {
                            
                            let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                            if let payload = parsedData["payload"] as? [String:Any]
                            {
                                if let items = payload["items"] as? [Any]
                                {
                                    if items.count > 0
                                    {
                                        if let item = items[0] as? [String:Any]
                                        {
                                            let articleId = item["id"] as! String
                                            let channelId = item["channelId"] as! String
                                            self.itemTitle = item["title"] as! String
                                            self.itemURLString = item["playbuzzUrl"] as! String
                                            
                                            self.sendStatisticsOfItemOpenedFromSDK(articleId: articleId, channelId: channelId, companyDomain: companyDomain)
                                        }
                                    }
                                }
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                    else
                    {
                        print("PlaybuzzSDK, getItemData: statusCode should be 200, but is \(httpStatus.statusCode). response = \(response)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func sendStatisticsOfItemOpenedFromSDK(articleId: String, channelId:String, companyDomain:String)
    {
        if let url = URL(string: "https://datacollection.playbuzz.com/PB-BD-Kinesis-Producer/")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let event = [
                "eventName": "page_view",
                "pageType": "app-sdk",
                "parentUrl": companyDomain,
                "sessionParentHost": companyDomain,
                "sessionIsMobieApp": true,
                "articleId": channelId,
                "sessionIsMobileWeb": true,
                "implementation": "app-sdk",
                "userId": articleId
            ] as [String: Any]

            request.httpBody = try! JSONSerialization.data(withJSONObject: event, options: [])

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("PlaybuzzSDK, sendStatisticsOfItemOpenedFromSDK: error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("PlaybuzzSDK, sendStatisticsOfItemOpenedFromSDK: statusCode should be 200, but is \(httpStatus.statusCode). response = \(response)")
                    print("response = \(response)")
                }
            }
            task.resume()
        }
    }
}


// MARK: - EmbededWebViewControllerProtocol
public protocol PlaybuzzQuizProtocol: class
{
    func resizePlaybuzzContainer(_ height: CGFloat)
    func presentShareViewController(_ viewController: UIViewController)
}
