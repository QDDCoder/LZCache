//
//  GoodModel.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import ObjectMapper
struct GoodModel : Mappable {
    init?(map: Map) {
        
    }
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        goodsId <- map["goodsId"]
        productId <- map["productId"]
        categoryName <- map["categoryName"]
        brandName <- map["brandName"]
        manufacturerName <- map["manufacturerName"]
        name <- map["name"]
        title <- map["title"]
        img <- map["img"]
        buyCount <- map["buyCount"]
        placeOrigin <- map["placeOrigin"]
        sellPrice <- map["sellPrice"]
    }
    
    var id : Int=0
    var goodsId : Int=0
    var productId : Int=1
    var categoryName:String = ""
    var brandName:String = ""
    var manufacturerName:String = ""
    var name:String = ""
    var title:String = ""
    var img:String = ""
    var buyCount:Int=0
    var placeOrigin:String = ""
    var sellPrice:Float=0.00
    
    var cellHeight:CGFloat = 178
    
    
}
