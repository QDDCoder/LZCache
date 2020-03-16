//
//  HomeApi.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import Moya
enum HomeApi:BaseApi{
    case getHomeInfo
}

extension HomeApi{
    var path: String{
        switch self {
        case .getHomeInfo:
            return "system/home"
        }
    }
    var method: Moya.Method{
        return .get
        
    }
    var cacheType: ApiCacheType{
        return .cache
    }
    var task: Task{
        switch self {
        case .getHomeInfo:
            return .requestParameters(parameters: ["":""], encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]?{
        var headers : [String: String] = [:]
        headers["Content-type"] = "application/json"
        return headers
    }
    var sampleData: Data{
        return Data()
    }
}

