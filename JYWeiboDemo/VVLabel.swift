//
//  VVLabel.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/14.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

@objc public protocol VVLabelDelegate: NSObjectProtocol {
    
    @objc optional func labelDidSelectedLinkText(label: VVLabel, text: String)

}

public class VVLabel: UILabel {
    
    public weak var delegate: VVLabelDelegate?
    
    public var linkTextColor = UIColor.blue
    
    public var selectedBackgroundColor = UIColor.lightGray

    

}
