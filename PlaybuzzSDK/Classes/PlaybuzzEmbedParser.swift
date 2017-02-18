//
//  EmbedParser.swift
//  Pods
//
//  Created by Luda Fux on 2/16/17.
//
//

import UIKit

class PlaybuzzEmbedParser: NSObject
{
    class func parseEmbedToGetItemID(_ embedCode:String) -> String?
    {
        
        let embedCodSeperatedByItemID = embedCode.components(separatedBy: "data-item=\"")
        
        if embedCodSeperatedByItemID.count > 1
        {
            var dataItemWithSufux: String = embedCodSeperatedByItemID[1]
            
            let itemID = dataItemWithSufux.components(separatedBy: "\"")[0]
            return itemID
        }
        return nil
    }
    
    class func parseEmbedToGetItemAlies(_ embedCode:String) -> String?
    {
        let embedCodSeperatedByItemAlies = embedCode.components(separatedBy: "data-game=\"")
        
        if embedCodSeperatedByItemAlies.count > 1
        {
            var dataItemWithSufux: String = embedCodSeperatedByItemAlies[1]
            
            let itemAlies = dataItemWithSufux.components(separatedBy: "\"")[0]
            return itemAlies
        }
        return nil
    }
    
    class func embedStringWithItemID(_ itemID: String,
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
    
    class func embedStringWithAlies(_ itemAlies: String,
                              companyDomain: String,
                              showItemInfo:Bool,
                              userID: String) -> String
    {
        let embedTamplate = "<!DOCTYPE html><html><head> <meta content=\"width=device-width\" name=\"viewport\"> <style>.pb_iframe_bottom{display:none;}.pb_top_content_container{padding-bottom: 0 !important;}</style></head><body> <script type=\"text/javascript\">window.PlayBuzzCallback=function(event){var messageDict={\"event_name\":event.eventName,data:event.data};window.webkit.messageHandlers.callbackHandler.postMessage(messageDict)}</script> <script src=\"//cdn.playbuzz.com/widget/feed.js\" type=\"text/javascript\"> </script> <div class=\"pb_feed\" data-native-id=\"%@\" data-game=\"%@\" data-recommend=false data-shares=false data-comments=false data-game-info=\"%@\" data-platform=\"iPhone\" ></div></body></html>"
        
        let embedString: String = String(format: embedTamplate,
                                         userID,
                                         itemAlies,
                                         showItemInfo ? "true":"false")
        return embedString
    }

}
