//
//  PlaybuzzView.swift
//  Pods
//
//  Created by Luda Fux on 11/9/16.
//
//

import UIKit
import WebKit

public class PlaybuzzView: UIView, WKScriptMessageHandler{
    
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
        
        if let itemID = self.parseEmbedToGetItemID(embedCode)
        {
            embedStringForMobile = self.embedStringWithItemID(itemID,
                                                              companyDomain: companyDomain,
                                                              showItemInfo: showItemInfo,
                                                              userID: userID)
            
            self.sendAnalitics(itemID, companyDomain:companyDomain)
        }
        
        webView.loadHTMLString(embedStringForMobile, baseURL: URL(string:companyDomain))
        
    }
    
    func embedStringWithItemID(_ itemID: String,
                               companyDomain: String,
                               showItemInfo:Bool,
                               userID: String) -> String
    {
        let embedTamplate = "<!DOCTYPE html><html><head> <meta content=\"width=device-width\" name=\"viewport\"> <style>.pb_iframe_bottom{display:none;}.pb_top_content_container{padding-bottom: 0 !important;}</style></head><body> <script type=\"text/javascript\">window.PlayBuzzCallback=function(event){var messageDict={\"event_name\":event.eventName,data:event.data};window.webkit.messageHandlers.callbackHandler.postMessage(messageDict)}</script> <script src=\"//cdn.playbuzz.com/widget/feed.js\" type=\"text/javascript\"> </script> <div class=\"pb_feed\" data-native-id=\"%@\" data-item=\"%@\" data-recommend=false data-shares=false data-comments=false data-game-info=\"%@\" data-platform=\"iPhone\" ></div></body></html>"
        
        let embedString: String = String(format: embedTamplate,
                                         userID,
                                         itemID,
                                         showItemInfo ? "true":"false")
        return embedString
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
    
    func sendAnalitics(_ itemID:String,
                     companyDomain: String)
    {
        
        if let url = URL(string: "http://rest-api-v2.playbuzz.com/v2/items?id=\(itemID)")
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
    
    func parseEmbedToGetItemID(_ embedCode:String) -> String?
    {
        
        let embedCodSeperatedByItemID = embedCode.components(separatedBy: "data-item=\"")
        
        if embedCodSeperatedByItemID.count > 1
        {
            var dataItemWithSufux: String = embedCodSeperatedByItemID[1]
        
            let itemID = dataItemWithSufux.components(separatedBy: "\"")[0]
            return itemID
        }
        else
        {
            let embedCodSeperatedByItemAlies = embedCode.components(separatedBy: "data-game=\"")
            
            if embedCodSeperatedByItemID.count > 1
            {
                var dataItemWithSufux: String = embedCodSeperatedByItemID[1]
                
                let itemID = dataItemWithSufux.components(separatedBy: "\"")[0]
                return itemID
            }
        }
        return nil
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
public protocol PlaybuzzViewProtocol: class
{
    func resizePlaybuzzContainer(_ height: CGFloat)
}
