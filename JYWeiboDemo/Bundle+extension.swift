//
//  Bundle+extension.swift
//  JYVVVeibo
//
//  Created by atom on 16/9/13.
//  Copyright © 2016年 atom. All rights reserved.
//

import Foundation

extension Bundle {
    
    var namespace: String {
    
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }

}
