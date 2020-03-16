//
//  NetWorking.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//
import Moya
final class NetWorking<Target: TargetType>: MoyaProvider<Target> {

    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        let manager = Manager(configuration: configuration)
        super.init(manager: manager, plugins: plugins)
    }
}
