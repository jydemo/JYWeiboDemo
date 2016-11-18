//
//  JVVStatus.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/12.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVStatus: NSObject {
    
    var id: Int64 = 0
    
    var text: String?
    
    var user: JVVUser?
    
    var reposts_count: Int = 0
    
    var comments_count: Int = 0
    
    var attitudes_count: Int = 0
    
    var created_at: String?
    
    var source: String? {
        
        didSet {
            
            source = "来自" + (source?.jvv_href()?.text ?? "未知")
        
        }
    
    }
    
    //var pic_urls: [VVStatusPictures]?
    
    var retweeted_status: JVVStatus?
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                user = JVVUser(dict: dict)
            
            }
            
            return
        
        }
        
        if "retweeted_status" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                retweeted_status = JVVStatus(dict: dict)
            
            }
            
            return
        
        }
        
        super.setValue(value, forKey: key)
        
    }
    
    class func status(array: [[String: AnyObject]]) -> [JVVStatus] {
        
        var models = [JVVStatus]()
        
        for dict in array {
            
            models.append(JVVStatus(dict: dict))
        
        }
        
        return models
    
    }

}

class VVStatusPictures: NSObject {
    
    var thumbnail_pic: String?
    
    

}
