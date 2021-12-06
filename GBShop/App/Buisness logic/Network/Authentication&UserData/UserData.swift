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
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

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
    
    func register(user: UserDataRequest, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = Register(baseUrl:baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func changeData(user: UserDataRequest, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void) {
        let requestModel = Register(baseUrl:baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)

    }

}

extension UserData {
    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"

        let user: UserDataRequest
        var parameters: Parameters? {
            return [
                "id_user" : user.id,
                "username" : user.userName,
                "password" : user.password,
                "email" : user.email,
                "gender": user.gender,
                "credit_card" : user.creditCard,
                "bio" : user.bio
            ]
        }
    }

    struct ChangeUserData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "changeUserData.json"
        let user: UserDataRequest

        var parameters: Parameters? {
            return [
                "id_user" : user.id,
                "username" : user.userName,
                "password" : user.password,
                "email" : user.email,
                "gender": user.gender,
                "credit_card" : user.creditCard,
                "bio" : user.bio            ]
        }


    }
}

