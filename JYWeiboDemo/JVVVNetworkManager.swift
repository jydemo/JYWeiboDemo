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

enum CWHttpMethod {
    
    case GET
    
    case POST

}

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
    
    class func postStatus(text: String, image: UIImage? = nil, completion: @escaping (_ result: [String: AnyObject]?, _ isSuccess: Bool) -> ()) {
            
            if image != nil {
                
                guard let pic = UIImagePNGRepresentation(image!), let token = vvAccessToken.data(using: .utf8), let status = text.data(using: .utf8) else {
                    
                    return
                
                }
                
                
                print("==========\(token)===================\(status)==============")
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    
                    multipartFormData.append(pic, withName: "pic", fileName: "code4swift.png", mimeType: "application/octet-stream")
                    
                    multipartFormData.append(token, withName: "access_token")
                    
                    multipartFormData.append(status, withName: "status")
                    
                }, to: "https://upload.api.weibo.com/2/statuses/upload.json", encodingCompletion: { (encodingResult) in
                    
                    switch encodingResult {
                        
                        case .success(let upload, _, _):
                        
                            upload.responseJSON(completionHandler: { (response) in
                                
                                completion(nil, true)
                                
                            })
                        
                        case .failure(let encodingError):
                        
                            print(encodingError)
                        
                            completion(nil, false)
                        
                    }
                    
                })
                
               
            
            } else {
                
                let parameters = ["access_token": vvAccessToken, "status": text]
        
                
                Alamofire.request("https://api.weibo.com/2/statuses/update.json", method: .post, parameters: parameters).response(completionHandler: { (response) in
                    
                    completion(nil, true)
                    
                })
        
        }
        
        
    
    }

}


