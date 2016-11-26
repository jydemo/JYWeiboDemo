//
//  CWComposeViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/24.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class CWComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        for item in itemArray {
        
            
            
        
        }
    
    }

}
