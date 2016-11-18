//
//  HomeViewController.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/10.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit


private let originalcellID = "originalcellID"

private let retweetCellID = "retweetCellID"


class HomeViewController: JVVBaseViewController {
    
    var rowHeightCache: [Int64: CGFloat] = [Int64: CGFloat]()
    
    fileprivate lazy var listViewModel = JVVStatusListViewModel()
    
   override func loadData() {
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            self.listViewModel.loadStatus(isPullup: false) { (isSuccess,shouldRefresh) in
                
                if self.isPullup == false {
                    
                    self.navigationController?.tabBarItem.badgeValue = nil
                    
                    UIApplication.shared.applicationIconBadgeNumber = 0
                
                }
                
                self.isPullup = false
                
                if shouldRefresh {
                    
                    //print(self.listViewModel.statusList.last?.status.text)
                    
                    self.tableView?.reloadData()
                
                }
            
            }
    
        }
    
    }

    @objc fileprivate func showFriendAction() {
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        rowHeightCache.removeAll()
        
        
    }

}

extension HomeViewController {
    
    override func setupTableView() {
        
        super.setupTableView()
        
        
       // navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontsize: 16, target: self, action: #selector(showFriendAction))
        //tableView?.rowHeight = 300
        
        //tableView?.estimatedRowHeight = 200
        
       tableView?.register(UINib(nibName: "JVVStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalcellID)
        tableView?.register(UINib(nibName: "JVVStatusRetweedCell", bundle: nil), forCellReuseIdentifier: retweetCellID)
    }

}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listViewModel.statusList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = listViewModel.statusList[indexPath.row]
        
        let cellID = viewModel.status.retweeted_Status == nil ? originalcellID : retweetCellID
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JVVStatusCell
        
        cell.viewModel = viewModel
        
        cell.delegate = self
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewModel = listViewModel.statusList[indexPath.row]
        
        print("row height \(viewModel.status.user?.name) ------- \(viewModel.rowHeight)")
        
        return viewModel.rowHeight
        
    }

}

extension HomeViewController: JVVStatusCellDelegate {
    
    

}
