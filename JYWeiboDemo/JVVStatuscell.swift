//
//  JVVStatusNormalCellTableViewCell.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/14.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit


@objc protocol JVVStatusCellDelegate: NSObjectProtocol{
    
    @objc optional func statusCellDidTapURLString(cell:JVVStatusCell,urlString:String)
    
}

class JVVStatusCell: UITableViewCell {
    
    weak var delegate: JVVStatusCellDelegate?
    
    var viewModel: JVVStatusViewModel? {
        
        didSet {
            
            //statusLabel.attributedText = viewModel?.statusAttrText
            
            if let model = viewModel {
                
                statusLabel.attributedText = model.statusAttrText
                
                headIV.vv_setImage(urlStr: model.status.user?.imageURL, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
                
                nameLabel.text = model.status.user?.name
                
                memberIV.image = model.status.user?.membrImage
                
                vipIV.image = model.status.user?.verified_img
                
                retweededTextLab?.attributedText = model.retweededAttrText
                
                retweetedButton.setTitle(model.retweetedStr!, for: .normal)
                
                commmentButton.setTitle(model.commentStr!, for: .normal)
                
                likeButton.setTitle(model.likeStr!, for: .normal)
                
                sourceLabel.text = model.status.source
                
                pictureView.viewModel = model
            
            }
            
            
        
        }
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.drawsAsynchronously = true
        
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
        statusLabel.delegate = self
        
        retweededTextLab?.delegate = self
        
        
        retweededTextLab?.layer.masksToBounds = true
        
        retweetedButton.backgroundColor = UIColor.groupTableViewBackground
        
        statusLabel.layer.masksToBounds = true
        
        statusLabel.backgroundColor = UIColor.white
        
        nameLabel.layer.masksToBounds = true
        
        nameLabel.backgroundColor = UIColor.white
        
        sourceLabel.layer.masksToBounds = true
        
        sourceLabel.backgroundColor = UIColor.white
        
        timeLabel.layer.masksToBounds = true
        
        timeLabel.backgroundColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rowHeight() -> CGFloat {
    
        
        self.layoutIfNeeded()
        
        return footerView.frame.maxY
    
    }
    
    
    @IBOutlet weak var headIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberIV: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var vipIV: UIImageView!
    @IBOutlet weak var statusLabel: VVLabel!
    @IBOutlet weak var retweetedButton: UIButton!
    @IBOutlet weak var commmentButton: UIButton!
    @IBOutlet weak var pictureView: JVVStatusPictureView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweededTextLab: VVLabel?
    @IBOutlet weak var footerView: UIView!
}

extension JVVStatusCell: VVLabelDelegate {
    
    

}
