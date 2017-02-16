//
//  AnalyticsManager.swift
//  Pods
//
//  Created by Luda Fux on 2/16/17.
//
//

import UIKit

class PlaybuzzAnalyticsManager: NSObject
{
    class func sendAnaliticsWithItemID(_ itemId: String, channelId:String, companyDomain:String)
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
                "userId": itemId
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
    
    class func sendAnaliticsWithItemAlies(_ itemAlies: String, channelId:String, companyDomain:String)
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
                "userId": itemAlies
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
