//
//  VMModel.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
class VMModel: ViewModelOrderType {
    var input: Input!
    var output: Output!
    struct Input {
        let getHomeInfo:AnyObserver<Void>
    }
    struct Output {
        let getHomeInfoOut:Driver<[GoodModel]>
    }
    ///账号密码登录的转换体
    private var getHomeInfoInputSubject:ReplaySubject<Void> = ReplaySubject<Void>.create(bufferSize: 1)
    init() {
        let getHomeInfoGreeting = getHomeInfoInputSubject.asObserver().flatMapLatest {[weak self] (model) -> Observable<[GoodModel]> in
            return (self?.getHomeInfoNet())!
        }
        input=Input(getHomeInfo: getHomeInfoInputSubject.asObserver())
        output=Output(getHomeInfoOut: getHomeInfoGreeting.asDriver(onErrorJustReturn: ([])))
    }
    ///获取首页的网络数据
    private func getHomeInfoNet() -> Observable<[GoodModel]> {
        let response = LZRequestManager.homeApi.getResponse(token: .getHomeInfo, with: .nomal).map { (data) -> [GoodModel] in
            
            if data != nil{
                let responseData:[String:Any] = data as? [String:Any] ?? ["":""]
                print("获取到的用户数据~~~\(data)")
                let goods: [GoodModel] = Mapper<GoodModel>().mapArray(JSONArray: (responseData["goodsList"] as? [[String : Any]])!)
                return goods
            }
            return []
            
        }
        return response
    }
}
