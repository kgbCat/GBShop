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
extension ProductData: ProductRequestFactory {

    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<[Product]>) -> Void) {
        let requestModel = CatalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func getProductByID(id: Int, completionHandler: @escaping (AFDataResponse<ProductInfoByID>) -> Void) {
        let requestModel = ProductByID(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductData {

    struct CatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"

        let pageNumber: Int
        let idCategory: Int
        
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": idCategory
            ]
        }
    }

    struct ProductByID: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "getGoodById.json"

        let id: Int

        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }


    }
}
