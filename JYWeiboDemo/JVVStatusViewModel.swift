//
//  JVVStatusViewModel.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/12.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class JVVStatusViewModel {
    
    var status: Status
    
    var  memberImg: UIImage?
    
    var vipImg: UIImage?
    
    var retweetedStr: String?
    
    var commentStr: String?
    
    
    var likeStr: String?
    
    var pictureViewSize = CGSize(width: 0, height: 0)
    
    var picURLs: [VVStatusPictures]? 
    
    var rowHeight: CGFloat = 0
    
    var statusAttrText: NSAttributedString?
    
    var retweededAttrText: NSAttributedString?
    
    init(model: Status) {
        
        self.status = model
        
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            
            memberImg = UIImage(named: imageName)
        
        }
        
        switch model.user?.verifed_type ?? -1 {
        case 0:
            vipImg = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipImg = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipImg = UIImage(named: "avatar_enterprise_vip")
        default:
            break
        }
        
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        pictureViewSize = calPictureViewSize(count: model.repic_urls?.count)
        
        let originalFont = UIFont.systemFont(ofSize: 15)
        
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        if let retweetedStatus = model.retweeted_Status, let name = retweetedStatus.user?.name, let text = retweetedStatus.text {
            
            let  rText = (name) + ":" + (text)
            
            retweededAttrText = emoticonString(rText, font: retweetedFont)
        
        }
        
        
        statusAttrText = emoticonString(model.text!, font: originalFont)
        
        
        updateReowHeight()
        
    }
    
    func updateReowHeight() {
        
        let margin: CGFloat = 12
        
        let iconHeight: CGFloat = 34
        
        let bottomBarHeight: CGFloat = 35
        
        let viewSize = CGSize(width: UIScreen.main.bounds.size.width - 2 * margin, height: CGFloat(MAXFLOAT))
    
        var height = 2 * margin + iconHeight + margin
        
        if let vvText = statusAttrText {
            
            height += vvText.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            
            if status.retweeted_Status != nil {
                
                height += 2 * margin
                
                if let text = retweededAttrText {
                    
                   height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
                
                }
            
            }
            
            height += pictureViewSize.height
            
            height += bottomBarHeight
            
            rowHeight = height
        
        }
    
    }
    
    func updateImageSize(image: UIImage){
        
        var size = image.size
        
        let maxWidth: CGFloat = 300
        
        let minWidth: CGFloat = 40
        
        if size.width >= maxWidth {
        
            
            size.width = maxWidth
            
            size.height = size.width * image.size.height / image.size.width
        }
        
        if size.width < minWidth {
            
            size.width = minWidth
            
            size.height = size.width * image.size.height/image.size.width / 4
        
        }
        
        size.height += pictrueOutterMargin
        
        pictureViewSize = size
        
        updateReowHeight()
    
    }
    
    private func calPictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil {
            
            return CGSize()
        
        }
        
        let row = (count! - 1)/3 + 1
        
        let height = pictrueOutterMargin + CGFloat(row) * JVVStatusPictrueItemWidth + CGFloat(row - 1) * pictrueInnerMargin
        
        return CGSize(width: jvvStatusPictrueViewWidth, height: height)
    
    }
    
    private func countString(count: Int, defaultStr: String) -> String{
        
        if count == 0 {
            
            return defaultStr
        
        }
        
        if count < 10000 {
            
            return count.description
        
        }
        
        return String(format: "%.02f 万", Double(count / 10000))
    
    }
    
    private func emoticonString(_ string: String, font: UIFont) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: string)
        
        /*let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
        
            return attrString
        
        }
        
        let range =  NSRange(location: 0, length: attrString.length)
        
        let matches = regx.matches(in: string, options: [], range: range)
        
        for m in matches {
            
            let r = m.rangeAt(0)
            
            let _ = (attrString.string as NSString).substring(with: r)
            
            
        
        }*/
        
        let range = NSRange(location: 0, length: attrString.length)
        
        attrString.addAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.darkGray], range: range)
        
        return attrString
    
    }
    

}
