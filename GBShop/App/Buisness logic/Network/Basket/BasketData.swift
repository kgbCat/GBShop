//
//  BasketData.swift
//  GBShop
//
//  Created by Anna Delova on 12/16/21.
//

import Foundation
import Alamofire


class BasketData:AbstractRequestFactory {

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


extension BasketData: BasketRequestFactory {
    func payBasket(creditCard: String, productId: Int, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Pay(baseUrl: baseUrl, productId: productId, creditCard: creditCard)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func addItemToBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = DeleteItem(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func deleteItemFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = AddItem(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension BasketData {
    struct AddItem: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod =  .post
        var path: String = "addItemtoBasket"

        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    struct DeleteItem: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod =  .post
        var path: String = "deleteItemFromBasket"

        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    struct Pay: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod =  .post
        var path: String = "payBasket"

        let productId: Int
        let creditCard: String
        var parameters: Parameters? {
            return [
                "productId": productId,
                "creditCard": creditCard
            ]
        }
    }
    
}



