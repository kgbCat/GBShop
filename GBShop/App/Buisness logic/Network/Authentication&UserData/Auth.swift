//
//  Auth.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {

    func logOut(request: LogoutRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, request: request)
        self.request(request: requestModel, completionHandler: completionHandler)
    }


    func login(request: AuthRequest, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, request: request)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"

        let request: AuthRequest
        var parameters: Parameters? {
            return [
                "userName": request.userName,
                "password": request.password
            ]
        }
    }

    struct Logout: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "logout"

        let request: LogoutRequest

        var parameters: Parameters? {
            return [
                "id": request.id 
            ]
        }


    }
}

