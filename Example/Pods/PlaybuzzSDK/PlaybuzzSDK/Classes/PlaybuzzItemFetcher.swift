//
//  PlaybuzzItemFetcher.swift
//  Pods
//
//  Created by Luda Fux on 2/16/17.
//
//

import UIKit

class PlaybuzzItemFetcher: NSObject
{
    class func getItemDataFrom(_ itemID:String,
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
                                            
                                            PlaybuzzAnalyticsManager.sendAnaliticsWithItemID(itemID, channelId: channelId, companyDomain: companyDomain)
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
}
