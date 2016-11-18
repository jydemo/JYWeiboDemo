//
//  JVVNewFeatureView.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVNewFeatureView: UIView {
    
    
    class func newFeatureView() -> JVVNewFeatureView {
        
        let nib = UINib(nibName: "JVVNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! JVVNewFeatureView
        
        v.frame = UIScreen.main.bounds
        
        
        return v
    
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
