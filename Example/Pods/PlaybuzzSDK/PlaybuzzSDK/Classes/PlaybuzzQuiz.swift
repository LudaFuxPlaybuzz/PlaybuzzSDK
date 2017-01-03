//
//  PlaybuzzQuiz.swift
//  Pods
//
//  Created by Luda Fux on 11/9/16.
//
//

import UIKit
import WebKit

public class PlaybuzzQuiz: UIView, WKScriptMessageHandler{
    
    var webView: WKWebView!
    public weak var delegate: PlaybuzzQuizProtocol?
    
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
        
        let embedTamplate = "<!DOCTYPE html><html><head> <meta content=\"width=device-width\" name=\"viewport\"> <style>.pb_iframe_bottom{display:none;}.pb_top_content_container{padding-bottom: 0 !important;}</style></head><body> <script type=\"text/javascript\">window.PlayBuzzCallback=function(event){var messageDict={\"event_name\":event.eventName,data:event.data};window.webkit.messageHandlers.callbackHandler.postMessage(messageDict)}</script> <script src=\"//cdn.playbuzz.com/widget/feed.js\" type=\"text/javascript\"> </script> <div class=\"pb_feed\" data-native-id=\"%@\" data-game=\"%@\" data-recommend=false data-shares=false data-comments=false data-game-info=\"%@\" data-platform=\"iPhone\" ></div></body></html>"
        
        let embedString: String = String(format: embedTamplate,
                                         userID,
                                         itemAlias,
                                         showItemInfo ? "true":"false")
        webView.loadHTMLString(embedString, baseURL: URL(string:companyDomain))
        self.getItemData()
//        self.sendStatisticsOfItemOpenedFromSDK()
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
    func getItemData()
    {
        if let url = URL(string: "http://rest-api-v2.playbuzz.com/v2/items?itemAlias=gigglebuzz10/can-you-name-all-20-of-these-fresh-prince-of-bel-air-characters")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("PlaybuzzSDK, getItemData: error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("PlaybuzzSDK, getItemData: statusCode should be 200, but is \(httpStatus.statusCode). response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }
            task.resume()
        }
    }
    
    func sendStatisticsOfItemOpenedFromSDK()
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
                "parentUrl": "http://www.example.com/luda.html",
                "sessionParentHost": "www.example.com",
                "sessionIsMobieApp": true,
                "articleId": "a402eeaa-92b8-4386-8191-ec5495a29ed3",
                "sessionIsMobileWeb": true,
                "implementation": "app-sdk",
                "userId": "7a4da078-80ec-4596-b1c6-506f87b47def"
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
}
