//
//  Product.swift
//  GBShop
//
//  Created by Anna Delova on 12/5/21.
//

import Foundation

struct Product: Codable {

    let id: Int
    let name: String
    let price: Int

    enum CodingKeys: String, CodingKey {

        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}

