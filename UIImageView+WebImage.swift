//
//  UIImageView+WebImage.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/14.
//  Copyright © 2016年 atom. All rights reserved.
//

import Kingfisher


extension UIImageView {
    
    func vv_setImage(urlStr: URL?, placeholderImage: UIImage?, isAvatar: Bool = false) {
        
        guard let urlStr = urlStr else {
            
            image = placeholderImage
            
            return
        
        }
        
        
        self.kf.setImage(with: urlStr, placeholder: placeholderImage, options: [], progressBlock: nil) { [unowned self] (image, _, _, _) in
            
            if isAvatar {
                
                self.image = image?.vvv_avatarImage(size: self.bounds.size)
            
            }
        
        }
        
       
    }

}
