//
//  JWViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/9.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JWViewController: UITabBarController {
    
    
    fileprivate lazy var composeButton: UIButton = UIButton.jy_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    fileprivate var timeer: Timer?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setupChildControllers()
        
        setupComposeBtn()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func setupChildControllers() {
    
        let array: [[String: Any]] = [
        
            ["clsName":"JWHomeViewController","title":"首页","imageName":"home","visitorInfo" : ["imageName": "","message":"关注一些人，回这里看看有什么惊喜"]],
            ["clsName":"JWMessageViewController","title":"消息","imageName":"message_center","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
            ["clsName":"UIViewcontroller"],
            ["clsName":"JWDiscoverViewController","title":"发现","imageName":"discover","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，最新、最热的微博尽在掌握中，不会再于实事潮流擦肩而过"]],
            ["clsName":"JWProfileViewController","title":"我的","imageName":"profile","visitorInfo" : ["imageName": "visitordiscover_image_profile","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
        
        ]
        
        var viewControllerArr = [UIViewController]()
        
        for dic in array {
            
            viewControllerArr.append(controller(dic))
        
        }
        
        viewControllers = viewControllerArr
    
    }
    
    fileprivate func controller(_ dic: [String: Any]) -> UIViewController {
        guard let clsName = dic["clsName"] as? String,
                let title = dic["title"] as? String,
                let imageName = dic["imageName"] as? String,
                let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? JVVBaseViewController.Type,
        
                let _ = dic["visitorInfo"] as? [String: String]
        
            else {
                
                return UIViewController()
        
        }
        
        let vc = cls.init()
        
        vc.title = title
        
        //vc.visitorInfoDic = visitorDic
        
        vc.tabBarItem.image = UIImage(named: imageName)
        
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        
        let nav = JVVNavigationController(rootViewController: vc)
        
        return nav
        
    }
    
    @objc fileprivate func composeBtnAction() {
        
        
    
    }

}

extension JWViewController {
    
    fileprivate func setupComposeBtn() {
        
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        
        let w = tabBar.frame.size.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        composeButton.addTarget(self, action: #selector(composeBtnAction), for: .touchUpInside)
    
    }

}
