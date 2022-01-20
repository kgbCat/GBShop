//
//  Review.swift
//  GBShop
//
//  Created by Anna Delova on 12/15/21.
//

import Foundation

struct Review: Codable {
    let customerName: String
    let productName: String
    let starCount: Int
    let review: String
    let reviewId: Int
}
