//
//  ProductInfoByID.swift
//  GBShop
//
//  Created by Anna Delova on 12/5/21.
//

import Foundation

struct ProductInfoByID: Codable {
    let result: Int
    let name: String
    let price: Int
    let description: String

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
//
//"result": 1,
//"product_name": "Ноутбук",
//"product_price": 45600,
//"product_description": "Мощный игровой ноутбук"
