//
//  JVVVNetworkManager.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/11.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import Alamofire

private let vvAccessToken = "2.009IxytBQHYE2Be1507ea6650oRSXl"

class JVVVNetworkManager {
    
    class func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion:@escaping (_ list:[Status]?,_ isSuccess: Bool)->()) {
        
        let url = "https://api.weibo.com/2/statuses/home_timeline.json?access_token=\(vvAccessToken)"
        
        let params = ["since_id": since_id, "max_id": max_id > 0 ? max_id - 1 : 0]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                if let dataJSON = response.result.value as? [String: AnyObject] {
                    
                    
                    let result = dataJSON["statuses"] as? [[String: AnyObject]]
                    
                    let statuses = Status.status(array: result)
                    
                    completion(statuses, true)
                    
                }
                
                
                
            }
            
        }

    
    }

}


