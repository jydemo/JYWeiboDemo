//
//  CWComposeTypeButton.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/28.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class CWComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var clsName: String?
    
    class func composeTypeButton(imageName: String, title: String) -> CWComposeTypeButton {
    
        
        let btn = UINib(nibName: "CWComposeTypeButton", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CWComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        
        btn.titleLabel.text = title
        
        return btn
    
    }

}
