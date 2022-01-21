//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/16/21.
//

import Foundation
import Alamofire


protocol BasketRequestFactory {

    func addItemToBasket(productId: Int, completionHandler: @escaping(AFDataResponse<DefaultUserDataResult>)-> Void)

    func deleteItemFromBasket(productId: Int, completionHandler: @escaping(AFDataResponse<DefaultUserDataResult>)-> Void)

    func payBasket(creditCard: String, totalSum: Int,
                   completionHandler: @escaping(AFDataResponse<DefaultUserDataResult>)-> Void)

}
