//
//  JVVMainViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVMainViewController: UITabBarController {
    
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChildController()
        
        setCompose()
        
        //setupTimer()
        
        //delegate = self
        
        //setupNewFeatureView()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(userLogin(not:)), name: NSNotification.Name(rawValue: JVVUserShouldLoginNotification), object: nil)
    }
    
    deinit {
        timer?.invalidate()
        
        //NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func userLogin(not: NSNotification) {
        
        
    
    }
    
    lazy var composeButton: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControlState(rawValue: 0))
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControlState(rawValue: 0))
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        
        return button
        
    }()
    
}

extension JVVMainViewController {
    
    func setCompose() {
        
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        
        let w = tabBar.bounds.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
    }
    
    func controllers(_ dict: [String: AnyObject]) -> UIViewController {
        
        guard let clsName = dict["clsName"] as? String, let title = dict["title"] as? String,
            
            let image = dict["imageName"] as? String,
            
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? JVVBaseViewController.Type
            
            else {
                
                return UIViewController()
                
        }
        
        let vc = cls.init()
        
        vc.title = title
        
        //vc.visitorInfoDic =
        
        vc.tabBarItem.image = UIImage(named: "tabbar_" + image)
        
        vc.tabBarItem.setBadgeTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        
        let nav = JVVNavigationController(rootViewController: vc)
        
        return nav
        
    }
    
    func setChildController(){
        
        let vcJSON = Bundle.main.path(forResource: "Main", ofType: "json")
        
        var vcDict: Any?
        
        do {
            
            let vcData = try Data(contentsOf: URL(fileURLWithPath: vcJSON!))
            
            vcDict = try JSONSerialization.jsonObject(with: vcData, options: .mutableContainers)
            
        } catch {
            
        }
        
        var newArry = [UIViewController]()
        
        for item in vcDict as! [[String: AnyObject]] {
            
            newArry.append(controllers(item))
            
        }
        
        viewControllers = newArry
        
    }
    
    fileprivate func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 240.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    
    }
    
    @objc fileprivate func updateTimer() {
        
        
        
    }
    
}

extension JVVMainViewController {
    
    fileprivate func setupNewFeatureView() {
        
        let v = isNewVersion ? JVVNewFeatureView.newFeatureView() : JVVWelcomeView.welcomeView()
        
        view.addSubview(v)
    
    }
    
    
    
    fileprivate var isNewVersion: Bool {
        
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        let beforeVersion = UserDefaults.standard.string(forKey: "YWVersionKey") ?? ""
        
        UserDefaults.standard.set(currentVersion, forKey: "YWVersionKey")
        
        return currentVersion != beforeVersion
    
    }

}

extension JVVMainViewController: UITabBarControllerDelegate {
}
