//
//  Review.swift
//  GBShop
//
//  Created by Anna Delova on 12/15/21.
//
import Foundation
import Alamofire

class ReviewData:AbstractRequestFactory {

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


extension ReviewData: ReviewRequestFactory {

    func getAllReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[Review]>) -> Void) {
        let requestModel = Get(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func addNewReview(review: Review, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Add(baseUrl: baseUrl, review: review)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func deleteReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<DefaultUserDataResult>) -> Void) {
        let requestModel = Delete(baseUrl: baseUrl, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension ReviewData {
    struct Get: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod =  .post
        var path: String = "getAllReviews"

        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    struct Add: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod =  .post
        var path: String = "addNewReview"
        let review: Review
        var parameters: Parameters? {
            return [
                "customerName": review.customerName,
                "productId": review.productId,
                "starCount": review.starCount,
                "review": review.review,
                "reviewId": review.reviewId,
            ]
        }
    }
    struct Delete: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "deleteReview"

        let reviewId: Int
        var parameters: Parameters? {
            return [
                "reviewId": reviewId
            ]
        }


    }
}



