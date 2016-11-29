//
//  CWRefreshControl.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/29.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

enum CWRefreshStatus {
    
    case Normal
    
    case Pulling
    
    case WillRefresh

}

fileprivate let CWRefreshOffset: CGFloat = 110

class CWRefreshControl: UIControl {

    fileprivate weak var scrollView: UIScrollView?
    
    fileprivate lazy var refreshView: CWRefreshView = CWRefreshView.refreshView()
    
    init() {
        
        super.init(frame: CGRect())
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        superview?.willMove(toSuperview: newSuperview)
        
        guard let  sv = newSuperview as? UIScrollView else {
            return
        }
        
        scrollView = sv
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            
            return
        
        }
        
        let  height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0 {
            
            return
        
        }
        
        if refreshView.refreshStatus != .WillRefresh {
            
            refreshView.parentViewHeight = height
        
        }
        
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        if sv.isDragging {
            
            if  height > CWRefreshOffset && refreshView.refreshStatus == .Normal {
                
                refreshView.refreshStatus = .Pulling
            
            } else if height <= CWRefreshOffset && refreshView.refreshStatus == .Pulling{
                
                refreshView.refreshStatus = .Normal
            
            }
        
        } else {
            
            if refreshView.refreshStatus == .Pulling {
                
                beginRefresh()
                
                sendActions(for: .valueChanged)
            
            }
        
        }
    
    }
    
    func beginRefresh() {
        
        guard let sv = scrollView else {
            
            return
        
        }
        
        if refreshView.refreshStatus == .WillRefresh {
            
            return
        
        }
        
        refreshView.refreshStatus = .WillRefresh
        
        var insert1 = sv.contentInset
        
        insert1.top += CWRefreshOffset
        
        sv.contentInset = insert1
        
        refreshView.parentViewHeight = CWRefreshOffset
    
    }
    
    func endRefreshing() {
        
        print("结束刷新")
        
        guard let sv = scrollView else {
            
            return
        
        }
        
        if refreshView.refreshStatus != .WillRefresh {
            
            return
        
        }
        
        refreshView.refreshStatus = .Normal
        
        var inset2 = sv.contentInset
        
        inset2.top -= CWRefreshOffset
        
        sv.contentInset = inset2
    
    }
    
    override func removeFromSuperview() {
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        
    }

}

extension CWRefreshControl {

    fileprivate func setupUI() {
        
        backgroundColor = superview?.backgroundColor
        
        addSubview(refreshView)
        
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.height))
    
    }

}
