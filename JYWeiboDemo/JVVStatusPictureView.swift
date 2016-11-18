//
//  JVVStatusPictureView.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/14.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVStatusPictureView: UIView {
    
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    var viewModel: JVVStatusViewModel? {
        
        didSet {
            
           
            calcViewSize()
            
            urls = viewModel?.status.repic_urls
            
            
        
        }
    
    }
    
    private var urls: [URL]? {
        
        didSet {
            
            guard let urlss = urls else  { return }
            
            for v in subviews {
                
                v.isHidden = true
            
            }
            
            var index = 0
            
            for url in urlss {
                
                let iv = subviews[index] as! UIImageView
                
                if index == 1 && urlss.count == 4 {
                    
                    index += 1
                
                }
                
                iv.vv_setImage(urlStr: url, placeholderImage: UIImage(named: "paceholder"))
                
                iv.isHidden = false
                
                index += 1
            
            }
        
        }
    
    }
    
    private func calcViewSize() {
        
        if let urls = viewModel?.status.repic_urls {
            
            if urls.count == 1 {
                
                let viewSize = viewModel?.pictureViewSize ?? CGSize()
                
                let v = subviews[0]
                
                v.frame = CGRect(x: 0, y: pictrueOutterMargin, width: viewSize.width, height: viewSize.height - pictrueOutterMargin)
                
            } else {
                
                let v = subviews[0]
                
                v.frame = CGRect(x: 0, y: pictrueOutterMargin, width: JVVStatusPictrueItemWidth, height: JVVStatusPictrueItemWidth)
                
            }
        
            
        
        }
        
        //print(viewModel?.pictureViewSize.height)
        
        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
        
    
    }
    
    
    override func awakeFromNib() {
        
        setupUI()
        
    }
    

}

extension JVVStatusPictureView {
    
    fileprivate func setupUI() {
        
        backgroundColor = superview?.backgroundColor
        
        clipsToBounds = true
        
        let rect = CGRect(x: 0, y: pictrueOutterMargin, width: JVVStatusPictrueItemWidth, height: JVVStatusPictrueItemWidth)
        
        let count = 3
        
        for i in 0..<9 {
            
            let row = CGFloat(i / count)
            
            let col = CGFloat(i % count)
            
            let iv = UIImageView(frame: rect)
            
            iv.contentMode = .scaleAspectFill
            
            iv.clipsToBounds = true
            
            let xOffset = col * (JVVStatusPictrueItemWidth + pictrueInnerMargin)
            
            let yOffset = row * (JVVStatusPictrueItemWidth + pictrueInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            iv.backgroundColor = UIColor.red
            
            addSubview(iv)
        }
    
    }

}
