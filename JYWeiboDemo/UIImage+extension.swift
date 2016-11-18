//
//  UIImage+extension.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/18.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

extension UIImage {
    
    func vvv_avatarImage(size: CGSize?, backColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.lightGray) -> UIImage?  {
        
        var size = size
        
        if size == nil || size?.width == 0 {
            
            size = CGSize(width: 34, height: 34)
        
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        
        path.addClip()
        
        draw(in: rect)
        
        let ovalPath = UIBezierPath(ovalIn: rect)
        
        ovalPath.lineWidth = 1
        
        lineColor.setStroke()
        
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    
    }

}
