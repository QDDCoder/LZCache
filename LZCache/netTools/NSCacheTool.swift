//
//  NSCacheTool.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import Cache
class NSCacheTool: NSObject {
    /// 生成单例对象
    static let shared = NSCacheTool()
    /// 网络请求
    fileprivate(set) var netWork: Storage<Data>?
    // MARK: - Initial Methods
    override init() {
        super.init()
        initNetWork()
    }
    // MARK: - Privater Methods
    fileprivate func initNetWork() {
        let dickConfig = DiskConfig(name: "NetWork", maxSize: 5 * 1024 * 1024)
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50)
        let transformer = Transformer<Data>.init(toData: { $0 }, fromData: { $0 })
        do {
            try netWork = Storage<Data>(diskConfig: dickConfig, memoryConfig: memoryConfig, transformer: transformer)
        } catch {
            
        }
    }
}
