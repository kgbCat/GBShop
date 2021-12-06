//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/5/21.
//

import Foundation
import Alamofire


protocol ProductRequestFactory {

    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<[Product]>) -> Void)

    func getProductByID(id: Int, completionHandler: @escaping(AFDataResponse<ProductInfoByID>)-> Void)

}
