//
//  CWComposeViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/24.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import SVProgressHUD

class CWComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    
    @IBAction func sendAction(_ sender: Any) {
        
        guard let text = textView.text else { return }
        
        let image = UIImage(named: "icon_small_kangaroo_loading_1")
        
        JVVVNetworkManager.postStatus(text: text, image: image) { (result, isSuccess) in
            
            let message = isSuccess ? "发布成功" : "网络不给力"
            
            SVProgressHUD.setDefaultStyle(.dark)
            
            SVProgressHUD.showInfo(withStatus: message)
            
            if isSuccess {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    
                    SVProgressHUD.setDefaultStyle(.light)
                    
                    self.backAction()
                })
            
            } else {
                
                
            
            }
        
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func backAction() {
        
        dismiss(animated: true, completion: nil)
    
    }

}

fileprivate extension CWComposeViewController {

   fileprivate func setupUI() {
    
        view.backgroundColor = UIColor.white
    
        setupNavgationBar()
    
        setToolBar()
    
    }
    
    fileprivate func setupNavgationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
    
        sendButton.isEnabled = false
        
        navigationItem.titleView = titleLabel
    
    }
    
    fileprivate func setToolBar() {
        
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        
        var itemArray = [UIBarButtonItem]()
        
        for item in itemSettings {
        
            guard let imageName = item["imageName"] else { return }
            
            let image = UIImage(named: imageName)
            
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let btn = UIButton()
            
            btn.setImage(image, for: .normal)
            
            btn.setImage(imageHL, for: .highlighted)
            
            btn.sizeToFit()
            
            itemArray.append(UIBarButtonItem(customView: btn))
            
            itemArray.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
        
        }
        
        itemArray.removeLast()
        
        toolBar.items = itemArray
    
    }

}

extension CWComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        print("长度====\(textView.text.characters.count)==")
        
        sendButton.isEnabled = textView.hasText
        
    }

}
