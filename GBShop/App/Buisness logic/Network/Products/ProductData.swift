//
//  ProductData.swift
//  GBShop
//
//  Created by Anna Delova on 12/5/21.
//

import Foundation
import Alamofire

class ProductData: AbstractRequestFactory {

    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
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
extension ProductData: ProductRequestFactory {

    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<[Product]>) -> Void) {
        let requestModel = CatalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func getProductByID(id: Int, completionHandler: @escaping (AFDataResponse<Product>) -> Void) {
        let requestModel = ProductByID(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductData {

    struct CatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductsData"

        let pageNumber: Int
        let idCategory: Int
        
        var parameters: Parameters? {
            return [
                "pageNumber": pageNumber,
                "categoryId": idCategory
            ]
        }
    }

    struct ProductByID: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "getProductByID"

        let id: Int

        var parameters: Parameters? {
            return [
                "productId": id
            ]
        }


    }
}
