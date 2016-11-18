//
//  JVVWelcomeView.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVWelcomeView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var bottomCon: NSLayoutConstraint!
    @IBOutlet weak var iconCons: NSLayoutConstraint!
    
    
    
    
    class func welcomeView() -> JVVWelcomeView {
        
        let nib = UINib(nibName: "JVVWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! JVVWelcomeView
        
        v.frame = UIScreen.main.bounds
        
        return v
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
