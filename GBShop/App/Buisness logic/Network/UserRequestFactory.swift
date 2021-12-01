//
//  UserRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

protocol UserRequestFactory {
    
    func register(user: UserDataRequest, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)

    func changeData(user: UserDataRequest, completionHandler: @escaping(AFDataResponse<ChangeDataResult>) -> Void)

}
