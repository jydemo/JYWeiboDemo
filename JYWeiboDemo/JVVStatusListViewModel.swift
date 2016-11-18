//
//  JVVStatusListViewModel.swift
//  JYWeiboDemo
//
//  Created by atom on 2016/11/12.
//  Copyright © 2016年 atom. All rights reserved.
//

import Foundation
import Kingfisher

import Alamofire


fileprivate let maxPullupTryTimes = 3


class JVVStatusListViewModel {
    
    lazy var  statusList = [JVVStatusViewModel]()
    
    fileprivate var pullupErrorTimes = 0
    
    func loadStatus(isPullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
    
        if  isPullup && pullupErrorTimes > maxPullupTryTimes {
            
            completion(true, false)
            
            return
        
        }
        
        let since_id = isPullup ? 0 : (statusList.last?.status.id ?? 0)
        
        let max_id = isPullup ? (statusList.last?.status.id ?? 0) : 0
        
        
        JVVVNetworkManager.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            if !isSuccess {
                
                completion(false, false)
                
                return
            }
            
            guard let statues = list else { return }
            
            var array = [JVVStatusViewModel]()
            
            for status in statues {
                
                array.append(JVVStatusViewModel(model: status))
            
            }
            
            if isPullup {
                
                self.statusList += array
            
            } else {
                
                self.statusList = array + self.statusList
            
            }
            
            if isPullup && statues.count == 0 {
                
                self.pullupErrorTimes += 1
                
                completion(isSuccess, false)
            
            } else {
                
                self.cacheSingleImage(list: array, finished: completion)
            
            }
            
            
        
        }
    
    }
    
    private func cacheSingleImage(list: [JVVStatusViewModel], finished:@escaping (_ isSuccess: Bool, _ shouldRefresh: Bool)->()) {
        
        let  group = DispatchGroup()
        
        var length = 0
        
        for vm in list {
            
            if vm.status.repic_urls?.count != 1 {
                
                continue
            
            }
            
            guard let picURL = vm.status.repic_urls?[0] else {
                continue
            }
            
            group.enter()
            
            KingfisherManager.shared.downloader.downloadImage(with: picURL, options: [], progressBlock: nil, completionHandler: { (image, error, url, data) in
                if let image = image, let data = UIImagePNGRepresentation(image) {
                
                    length += data.count
                    
                    vm.updateImageSize(image: image)
                
                }
                
                group.leave()
            })
        
        }
        
        group.notify(queue: DispatchQueue.main) {
            
            print("图像缓存\(length/1024)k")
            
            finished(true, true)
        }
    }
}
