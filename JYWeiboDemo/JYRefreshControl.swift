//
//  JYRefreshControl.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/18.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

enum JYRefreshStaus {
    
    case Normal
    
    case Pulling
    
    case Willrefresh

}

fileprivate let JYRefreshOffset: CGFloat = 122

class JYRefreshControl: UIRefreshControl {

    
    fileprivate weak var scrollView: UIScrollView?
    
    fileprivate lazy var refreshView: JYRefreshView = JYRefreshView.refreshView()
    
    override init() {
        
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let sv = newSuperview as? UIScrollView else {
            
            return
        
        }
        
        scrollView = sv
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            
            return
        
        }
        
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0 {
            
            return
        
        }
        
        if refreshView.refreshStatus != .Willrefresh {
            
            refreshView.parentViewHeight = height
        
        }
        
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        if sv.isDragging {
            
            if height > JYRefreshOffset && refreshView.refreshStatus == .Normal {
                
                refreshView.refreshStatus = .Pulling
            
            } else if height <= JYRefreshOffset && refreshView.refreshStatus == .Pulling {
                
                refreshView.refreshStatus = .Normal
            
            }
        
        } else {
            
            if refreshView.refreshStatus == .Pulling {
                
                beginrefresh()
                
                sendActions(for: .valueChanged)
                
            }
        
        }
        
    }
    
    override func removeFromSuperview() {
        
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        
        
    }
    
    func beginrefresh() {
        
        guard let sv = scrollView else { return }
        
        if refreshView.refreshStatus == .Willrefresh {
            
            return
        
        }
        
        refreshView.refreshStatus = .Willrefresh
        
        var inset1 = sv.contentInset
        
        inset1.top = JYRefreshOffset
        
        sv.contentInset = inset1
        
        refreshView.parentViewHeight = JYRefreshOffset
    
    }
    
    override func endRefreshing() {
        
        guard  let sv = scrollView else {
            return
        }
        
        if refreshView.refreshStatus != .Willrefresh {
            
            return
        
        }
        
        refreshView.refreshStatus = .Normal
        
        var insert = sv.contentInset
        
        insert.top -= JYRefreshOffset
        
        sv.contentInset = insert
    }

}

extension JYRefreshControl {
    
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
