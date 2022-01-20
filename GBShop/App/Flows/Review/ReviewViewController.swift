//
//  ReviewViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/29/21.
//

import UIKit

class ReviewViewController: UIViewController {

    let requestFactory = RequestFactory()
    var reviews: Review!

    override func viewDidLoad() {
        super.viewDidLoad()

//        deleteReview(reviewId: 3)
//        getReviews(productId: 123)
//        addReview(review: Review(customerName: "Anna", productName: "Macbook", starCount: 5, review: "nice", reviewId: 3))

    }

}
extension ReviewViewController {

    func getReviews(productId: Int) {
        let request = requestFactory.makeReviewRequestFactory()
        request.getAllReviews(productId: productId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func deleteReview(reviewId: Int) {
        let request = requestFactory.makeReviewRequestFactory()
        request.deleteReview(reviewId: reviewId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func addReview(review: Review) {
        let request = requestFactory.makeReviewRequestFactory()
        request.addNewReview(review: review) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

