//
//  Status.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SVProgressHUD

import Alamofire

class Status: NSObject {
    
    var created_at: String? {
    
        didSet {
        
           
        }
    }
    
    var id: Int64 = 0
    
    var text: String?
    
    var source: String? {
        
        didSet {
            
            source = "来自" + (source?.jvv_href()?.text ?? "未知")
        
        }
    
    }
    
    var stordPictureURLs: [URL]?
    
    var stordLagrePictureURLs: [URL]?
    
    var pic_urls: [[String: AnyObject]]? {
        
        didSet {
            
            if pic_urls?.count == 0 {
                
                return
            
            }
            
            stordPictureURLs = [URL]()
            
            stordLagrePictureURLs = [URL]()
            
            for dict in pic_urls! {
                
                if let urlString = dict["thumbnail_pic"] as? String {
                    
                    stordPictureURLs?.append(URL(string: urlString)!)
                    
                    let largeURLs = urlString.replacingOccurrences(of: "thumbnail", with: "large")
                    
                    stordLagrePictureURLs?.append(URL(string: largeURLs)!)
                
                }
            
            }
        
        }
    
    }
    
    
    
    
    var user: User?
    
    /*reposts_count	int	转发数
    comments_count	int	评论数
    attitudes_count	int	表态数*/
    
    var comments: [Comments]?
    
    var reposts_count: Int = 0
    
    var comments_count: Int = 0
    
    var attitudes_count: Int = 0
    
    var retweeted_Status: Status? 
    
    var repic_urls: [URL]? {
        
        
        return retweeted_Status != nil ? retweeted_Status?.stordPictureURLs : stordPictureURLs
    
    }
    
    var LargePictrueURLs: [URL]? {
    
        return retweeted_Status != nil ? retweeted_Status?.stordLagrePictureURLs : stordLagrePictureURLs
    }
    
    static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    
    var pictureViewSize = CGSize()
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        //setValuesForKeysWithDictionary(dict)
        
        setValuesForKeys(dict)
        
    }
    
     //private 
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //print("找不到\(key)")
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
               // print("\(dict)")
                
                
                user = User(dict: dict)
            }
            
            return
        }
        
        if "retweeted_status" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                retweeted_Status = Status(dict: dict)
                
                
                
            }
            
            return
            
        }
        
        super.setValue(value, forKey: key)
    }
    
    //private 
    
    class func status(array: [[String: AnyObject]]?) -> [Status]? {
    
        var models = [Status]()
        
        guard let dic = array else { return nil }
        
        for dicts in dic {
            
            models.append(Status(dict: dicts))
        
        }
        
        return models
    }
    
    
    class func footerData(reposts_count: Int, comments_count: Int, attitudes_count: Int) -> [String: Int] {
    
        
        return ["reposts_count": reposts_count, "comments_count": comments_count, "attitudes_count": attitudes_count
            
        ]
        
    }

}

class JVVStatusPictures: NSObject {
    
    var thumbnail_pic: String?
    
    
    
}
