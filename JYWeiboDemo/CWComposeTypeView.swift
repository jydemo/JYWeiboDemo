//
//  CWComposeTypeView.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/26.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import pop

class CWComposeTypeView: UIView {
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var returnCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var returnCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var closeCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var closeCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字","clsName": "YWComposeViewController"],
                                   ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                                   ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                                   ["imageName": "tabbar_compose_lbs", "title": "签到"],
                                   ["imageName": "tabbar_compose_review", "title": "点评"],
                                   ["imageName": "tabbar_compose_more", "title": "更多","actionName":"moreAction"],
                                   ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                                   ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                                   ["imageName": "tabbar_compose_music", "title": "音乐"],
                                   ["imageName": "tabbar_compose_shooting", "title": "拍摄"]]
    
    fileprivate var completionBlock:((_ clsNane: String?) -> ())?
    
    class func composeTypeView() -> CWComposeTypeView {
        
        let nib = UINib(nibName: "CWComposeTypeView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! CWComposeTypeView
        
        view.frame = UIScreen.main.bounds
        
        view.setupUI()
        
        return view
        
    }
    
    func show(completion: @escaping (_ clsName: String?) -> ()) {
        
        completionBlock = completion
        
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            
            return
        
        }
        
        vc.view.addSubview(self)
        
        
    
    }
    @IBAction func closeAction(_ sender: UIButton) {
        
        print("sender \(sender)")
        
        hiddenButtons()
    }
    @IBAction func returnButton(_ sender: Any) {
    }
    
    func addBtns(view: UIView, index: Int) {
    
        /*let count = 6
        
        for i in index..<(index + count) {
            
            if i >= buttonsInfo.count {
                
                break
            
            }
            
            let dic = buttonsInfo[i]
            
            guard let imageName = dic["imageName"], let title = dic["title"] else {
                continue
            }
            
            //let btn = CW
        
        }*/
    
    }

}

fileprivate extension CWComposeTypeView {
    
    func setupUI() {
    
        
        layoutIfNeeded()
        
        let rect = scrollView.bounds
        
        for i in 0..<2 {
        
            
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * scrollView.bounds.width, dy: 0))
            
            addBtns(view: v, index: i * 6)
            
            scrollView.addSubview(v)
            
            scrollView.contentSize = CGSize(width: 2 * scrollView.bounds.width, height: scrollView.bounds.height)
        
            scrollView.showsHorizontalScrollIndicator = false
            
            scrollView.bounces = false
            
            scrollView.isScrollEnabled = false
        }
    
    }


}

fileprivate extension CWComposeTypeView {

    func hiddenButtons() {
    
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        let view = scrollView.subviews[page]
        
        self.removeFromSuperview()
        
        for (i, btn) in view.subviews.enumerated() {
            
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            anim.fromValue = btn.center.y
            
            anim.toValue = btn.center.y + 350
            
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(view.subviews.count - 1) * 0.025
            
            btn.pop_add(anim, forKey: nil)
            
            if i == 0 {
                
                anim.completionBlock = {_, _ in
                    
                    self.hideCurrentView()
                
                }
            
            }
        
        }
    
    
    }
    
    func hideCurrentView() {
        
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        
        anim.toValue = 0
        
        anim.duration = 0.25
        
        pop_add(anim, forKey: nil)
        
        anim.completionBlock = {_, _ in
            
            self.removeFromSuperview()
        
        }
    
    }

}

    
