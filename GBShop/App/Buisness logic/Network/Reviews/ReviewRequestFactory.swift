//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/15/21.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func getAllReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[Review]>) -> Void)

    func addNewReview(review: Review, completionHandler: @escaping(AFDataResponse<DefaultUserDataResult>)-> Void)

    func deleteReview(reviewId: Int, completionHandler: @escaping(AFDataResponse<DefaultUserDataResult>)-> Void)

}
