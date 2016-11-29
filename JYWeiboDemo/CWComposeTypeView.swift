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
    
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字","clsName": "CWComposeViewController"],
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
        
        hiddenButtons()
    }
    
    @IBAction func returnButton(_ sender: Any) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        closeCenterX.constant = 0
        
        returnCenterX.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.layoutIfNeeded()
            
            self.returnButton.alpha = 0
        
        }) { (_) in
            
           self.returnButton.isHidden = true
        
            self.returnButton.alpha = 1
        }
        
    }
    
    @objc fileprivate func btnAction(selectedbutton: CWComposeTypeButton) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        let view = scrollView.subviews[page]
        
        for (i, btn) in view.subviews.enumerated() {
            
            let scaleAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            
            let scale = (selectedbutton == btn) ? 2 : 0.2
            
            scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            
            scaleAnim.duration = 0.5
            
            btn.pop_add(scaleAnim, forKey: nil)
            
            let alphaAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            
            alphaAnim.toValue = 0.2
            
            alphaAnim.duration = 0.5
            
            btn.pop_add(alphaAnim, forKey: nil)
            
            if i == 0 {
                
                alphaAnim.completionBlock = { _, _ in
                    
                    self.completionBlock?(selectedbutton.clsName)
                
                }
            
            }
        
        }
        
    }
    
    @objc fileprivate func moreAction() {
        
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        
        let margin = scrollView.bounds.width / 6
        
        returnButton.isHidden = false
        
        closeCenterX.constant += margin
        
        returnCenterX.constant -= margin
        
        UIView.animate(withDuration: 0.25) {
        
            self.layoutIfNeeded()
        
        }
    
    }
    
    func addBtns(view: UIView, index: Int) {
    
        let count = 6
        
        for i in index..<(index + count) {
            
            if i >= buttonsInfo.count {
                
                break
            
            }
            
            let dic = buttonsInfo[i]
            
            guard let imageName = dic["imageName"], let title = dic["title"] else {
                continue
            }
            
            let btn = CWComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            view.addSubview(btn)
            
            if let actionName = dic["actionName"] {
            
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            
            } else {
                
                btn.addTarget(self, action: #selector(btnAction(selectedbutton:)), for: .touchUpInside)
            
            }
            
            btn.clsName = dic["clsName"]
        
        }
        
        let btnSize = CGSize(width: 100, height: 100)
        
        let margin = (view.bounds.width - 3 * btnSize.width) / 4
        
        for (i, btn) in view.subviews.enumerated() {
        
            let y: CGFloat = ( i > 2) ? (view.bounds.height - btnSize.height) : 0
            
            let x = CGFloat((i % 3) + 1) * margin + CGFloat(i % 3) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        
        }
    
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

    
