//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)

    func logOut(id: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
