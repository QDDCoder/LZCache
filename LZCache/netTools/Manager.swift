//
//  Manager.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class LZRequestManager: NSObject {
    static let homeApi = NetWorking<HomeApi>()
}
///响应的model
enum ResponseType:Int {
    case nomal=1
    case netNoData=2
}

extension MoyaProviderType{
    func getResponse(token: Target,with type:ResponseType) -> Observable<AnyObject?> {
        return Observable.create { [weak self] observer in
                   
           /// 判断是否需要缓存
           if let baseApi = token as? BaseApi{
            self?.getCacheAction(baseApi, observer: observer)
           }
        print("缓存获取完毕 还需要请求网络吗~~~~~~")
            let cancellableToken = self?.request(token, callbackQueue: .main, progress: nil, completion: { (result) in
                print("缓存获取完毕 还需要请求网络吗2222222~~~~~~\(result)")
                switch result{
                case .success(let response):
                    if let baseApi = token as? BaseApi{
                        observer.onNext(self?.transform(token: baseApi, with: response, with: type))
                    }
                case .failure(let error):
                    observer.onNext(nil)
                    print("请求失败")
                }
            })
           
           return Disposables.create {
               cancellableToken?.cancel()
           }
       }
    }
    
    
    private func transform(token: BaseApi,with response:Response,with responseType:ResponseType) -> AnyObject? {
        print("请求的状态====\(response.statusCode)")
        if response.statusCode == 200{
            do {
                let dic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                
                if (dic?["code"] as? String ?? "0") == "1" {
                    
                    switch responseType {
                    case .nomal:
                        if JSONSerialization.isValidJSONObject(dic?["data"]){
                            let data = try JSONSerialization.data(withJSONObject: dic?["data"], options: [])
                            setCacheAction(token, data: data)
                        }
                        
                        return dic?["data"] as AnyObject
                    case .netNoData:
                        setCacheAction(token, data: dic?["msg"] as? Data ?? Data())
                        return dic?["msg"] as AnyObject?
                    }
                }else{
                    if (dic?["code"] as! String) == "0"{
                        return nil
                    }else if (dic?["code"] as! String) == "-3"{
                        
                        //个人中心 因为要时刻监测token 需要展示 未登录信息
//                        if ((response.request?.url?.absoluteString.contains(getUserUrl))!  || (response.request?.url?.absoluteString.contains(getNoticeUrl))!){
//                            print("个人中心新的处理~~~~~")
//                            return nil
//                        }else{
//
//                            print("未登录 去登陆")
//                        }
                    }
                    return nil
                }
            } catch {
                return nil
            }
        }else { ///服务器异常
            
            return nil
        }
    }
    
    
    
    
    /// 获取网络缓存
    ///
    /// - Parameters:
    ///   - token: api token
    ///   - observer: rx service
    fileprivate func getCacheAction(_ token: BaseApi, observer: AnyObserver<AnyObject?>) {
        guard token.cacheType != .none else { return }
        // 先读取缓存内容，有则发出一个信号（onNext），没有则跳过
        NSCacheTool.shared.netWork?.async.object(forKey: token.cacheKey, completion: { [weak self] (result) in
            switch result {
            case .value(let value):
                
                let dic = try? JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                observer.onNext(dic as AnyObject?)
                observer.onCompleted()
            case .error(let error):
                observer.onNext(nil)
                observer.onCompleted()
                print("读取缓存失败 \(error.localizedDescription)")
            }
        })
    }

    /// 存入网络缓存
    ///
    /// - Parameters:
    ///   - token: api token
    ///   - data: 存储数据data
    fileprivate func setCacheAction(_ token: BaseApi, data: Data){
        guard token.cacheType != .none else { return }
        print("保存的数据~~~~\(data)")
        
        
        
        NSCacheTool.shared.netWork?.async.setObject(data, forKey: token.cacheKey, completion: { (result) in
            switch result {
            case .value( _):
                print("缓存成功")
            default:
                print("缓存失败")
            }
        })
    }
}
