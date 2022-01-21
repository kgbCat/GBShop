//
//  UserData.swift
//  GBShop
//
//  Created by Anna Delova on 12/2/21.
//

import Foundation
import Alamofire

class UserData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: Constants.baseUrl)!
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension UserData: UserRequestFactory {
    
    func register(user: UserDataRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Register(baseUrl:baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func changeData(user: UserDataRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl:baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)

    }

}

extension UserData {
    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post

        let path: String = "register"

        let user: UserDataRequest
        var parameters: Parameters? {
            return [
                "userName" : user.userName,
                "password" : user.password,
                "email" : user.email,
                "creditCard" : user.creditCard,
            ]
        }
    }

    struct ChangeUserData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "changeRegistrationData"
        let user: UserDataRequest

        var parameters: Parameters? {
            return [
                "userName" : user.userName,
                "password" : user.password,
                "email" : user.email,
                "creditCard" : user.creditCard,
            ]
        }


    }
}

