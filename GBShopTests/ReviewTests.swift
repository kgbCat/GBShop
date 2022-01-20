//
//  ReviewTests.swift
//  GBShopTests
//
//  Created by Anna Delova on 12/20/21.
//


import XCTest
import Alamofire
@testable import GBShop

class ReviewTests: XCTestCase {

    var requestFactory: RequestFactory!

    override func setUp()  {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        requestFactory = nil
    }


    func testGetAllReviews() {
        let id = 123
        let review = requestFactory.makeReviewRequestFactory()
        let expecation = expectation(description: "Added")
        review.getAllReviews(productId: id){ response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.count, 6)

                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }

    func testDelete() {
        let id = 123
        let review = requestFactory.makeReviewRequestFactory()
        let expecation = expectation(description: "Deleted")
        review.deleteReview(reviewId: id){ response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Отзыв номер \(id) Удален")
                XCTAssertEqual(model.errorMessage, nil)
                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }

    func testAdd() {
        let mockRequest = Review(customerName: "Anna", productName: "Test", starCount: 4, review: "wsedrfty", reviewId: 4)
        let review = requestFactory.makeReviewRequestFactory()
        let expecation = expectation(description: "Added")
        review.addNewReview(review: mockRequest) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage,  "Отзыв номер \(mockRequest.reviewId) Добавлен")
                XCTAssertEqual(model.errorMessage, nil)
                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }



}

