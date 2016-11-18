//
//  JVVUserAccount.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/11.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

private let accountFile: String = "userAccount.json"

class JVVUserAccount: NSObject {
    
    var access_token: String?
    
    var uid: String?
    
    var expiress_in: TimeInterval = 0 {
    
        didSet {
            
            expiresDate = Date(timeIntervalSinceNow: expiress_in)
        
        }
    
    }
    
    var expiresDate: Date?
    
    var screen_name: String?
    
    var avatar_large: String?
    
    
    
    override init() {
        
        super.init()
        
        guard let path = accountFile.vvAppendDocumentDir() else { return }
        
        if expiresDate?.compare(Date()) == .orderedAscending {
            
            access_token = nil
            
            uid = nil
            
            _ = try? FileManager.default.removeItem(at: path)
        
        }
        
    }
    
}
