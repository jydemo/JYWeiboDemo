//
//  JVVBaseViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVBaseViewController: UIViewController {
    
    var isPullup = false
    
    var tableView: UITableView?
    
    func loadData() {
        
        
    
    }
    
    
    var visitorInfoDic: [String: String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUI()
        
        loadData()
        
    }
    
    override var title: String? {
        
        didSet {
            
            navItem.title = title
            
        }
        
    }
    
   
    
    
    
    lazy var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem: UINavigationItem = UINavigationItem()
    
    
}

extension JVVBaseViewController {
    
    func setUI() {
        
        view.backgroundColor = UIColor.white
        
        automaticallyAdjustsScrollViewInsets = false
        
        setNavBar()
        
        setupTableView()
        
    }
    
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
    
        view.insertSubview(tableView!, belowSubview: navBar)
        
        tableView?.delegate = self
        
        tableView?.dataSource = self
        
        tableView?.contentInset = UIEdgeInsets(top: navBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.frame.size.height ?? 49, right: 0)
        
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
    
    }
    
    fileprivate func setNavBar() {
        
        view.addSubview(navBar)
        
        navBar.items = [navItem]
        
        navBar.barTintColor = UIColor(red: 246, green: 246, blue: 246, alpha: 1)
        
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        
    }
    
}

extension JVVBaseViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let section = tableView.numberOfSections
        
        if row < 0 || section < 0 {
            
            return
        
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if (row == count - 1) && !isPullup {
            
            isPullup = true
            
            
        
        }
    }

}
