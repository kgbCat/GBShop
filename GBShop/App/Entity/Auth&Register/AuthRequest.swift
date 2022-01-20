//
//  AuthRequest.swift
//  GBShop
//
//  Created by Anna Delova on 12/13/21.
//

import Foundation


struct AuthRequest: Codable {

    var userName: String
    var password: String

}

struct LogoutRequest: Codable {

    var id: Int

}
