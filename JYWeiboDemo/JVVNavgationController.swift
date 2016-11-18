//
//  JVVNavgationController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationBar.isHidden = true
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? JVVBaseViewController {
                
                var navTitle = "返回"
                
                if childViewControllers.count == 1 {
                    
                    navTitle = childViewControllers.first?.title ?? "首页"
                    
                }
                
                let btn = UIButton.jyTextButton(navTitle, fontSize: 16, color: UIColor.red, heightColor: UIColor.orange)
                
                btn.addTarget(self, action: #selector(popToPre), for: .touchUpInside)
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
                
            }
            
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    
    @objc fileprivate func popToPre() {
        
        popViewController(animated: true)
        
    }
    
}
