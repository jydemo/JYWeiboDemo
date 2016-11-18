//
//  VVLabel.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/14.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

@objc protocol VVLabelDelegate: NSObjectProtocol {
    
    @objc optional func labelDidSelectedLinkText(label: VVLabel, text: String)

}

public class VVLabel: UILabel {
    
    weak var delegate: VVLabelDelegate?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
