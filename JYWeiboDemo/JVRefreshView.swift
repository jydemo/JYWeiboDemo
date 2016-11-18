//
//  JVRefreshView.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/18.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JYRefreshView: UIView {
    
    @IBOutlet weak var tipLabel: UILabel?
    
    @IBOutlet weak var tipIcon: UIImageView?
    
    @IBOutlet weak var tipIndicator: UIActivityIndicatorView?
    

    var refreshStatus: JYRefreshStaus = .Normal {
        
        didSet {
            
            switch refreshStatus {
                
                case .Normal:
                
                    tipIcon?.isHidden = false
                
                    tipIndicator?.stopAnimating()
                
                    tipLabel?.text = "继续使劲拉..."
                
                    UIView.animate(withDuration: 0.25, animations: { 
                        self.tipIcon?.transform = CGAffineTransform.identity
                    })
                
                case .Pulling:
                
                    tipLabel?.text = "放手就刷新..."
                
                    UIView.animate(withDuration: 0.25, animations: { 
                        self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                    })
                
                case .Willrefresh:
                
                    tipLabel?.text = "正在刷新中..."
                
                    tipIcon?.isHidden = true
                
                    tipIndicator?.startAnimating()
            }
        
        }
    
    }
    
    var parentViewHeight: CGFloat = 0
    
    class func refreshView() -> JYRefreshView {
    
        let nib = UINib(nibName: "JYRefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! JYRefreshView
    }

}
