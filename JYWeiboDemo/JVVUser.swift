//
//  JVVUser.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/12.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVUser: NSObject {
    
    var id: Int64 = 0
    
    var screen_name: String?
    
    var profile_image_url: String?
    
    var verifed_type: Int = 0
    
    var  mbrank: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
