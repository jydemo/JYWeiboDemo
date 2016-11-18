//
//  String+Extension.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/11.
//  Copyright © 2016年 atom. All rights reserved.
//

import Foundation

extension String {
    
    func vvAppendDocumentDir() -> URL? {
        
        guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last, let url = URL(string:  dir), let lastURL = URL(string: self) else { return nil }
        
        return url.appendingPathComponent(lastURL.lastPathComponent)
    
    }
    
    
    func jvv_href() -> ((link: String, text: String))? {
        
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        guard let regxx = try? NSRegularExpression(pattern: pattern, options: []),
        
            let result = regxx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) else { return nil }
        
        let link = (self as NSString).substring(with: result.rangeAt(1))
        
        let text = (self as NSString).substring(with: result.rangeAt(2))
        
        return (link, text)
    
    }

}
