//
//  UIButtonExtension.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/9.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func jy_imageButton(_ imageName: String, backgroundImageName: String) -> UIButton {
        
        let button = UIButton()
        
        
        button.setImage(UIImage(named: imageName), for: .normal)
        
        let imageHL = imageName.appending("_highlighted")
        
        let backgroundImageHL = backgroundImageName.appending("_highlighted")
        
        button.setImage(UIImage(named: imageHL), for: .highlighted)
        
        button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        
        button.setBackgroundImage(UIImage(named: backgroundImageHL), for: .highlighted)
        
        return button
    
    }
    
    class func jyTextButton(_ title: String, fontSize: CGFloat, color: UIColor = UIColor.blue, heightColor: UIColor) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        button.setTitleColor(heightColor, for: .highlighted)
        
        button.sizeToFit()
        
        return button
        
    }

}
