//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(request: AuthRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void)

    func logOut(request: LogoutRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void)
}
