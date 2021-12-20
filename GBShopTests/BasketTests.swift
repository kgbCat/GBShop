//
//  BasketTests.swift
//  GBShopTests
//
//  Created by Anna Delova on 12/20/21.
//

import XCTest
import Alamofire
@testable import GBShop

class BasketTests: XCTestCase {

    var requestFactory: RequestFactory!

    override func setUp()  {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        requestFactory = nil
    }


    func testAddItem() {
        let id = 123
        let basket = requestFactory.makeBasketRequestFactory()
        let expecation = expectation(description: "Added")
        basket.addItemToBasket(productId: id) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, " Товар с номером \(id) Добавлен в корзину")
                XCTAssertEqual(model.errorMessage, nil)
                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }

    func testDeleteItem() {
        let id = 123
        let basket = requestFactory.makeBasketRequestFactory()
        let expecation = expectation(description: "Deleted")
        basket.deleteItemFromBasket(productId: id) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, " Товар с номером \(id) Удален из корзины")
                XCTAssertEqual(model.errorMessage, nil)
                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }

    func testPay() {
        let id = 123
        let card = "1234567"
        let sum = 1234
        let basket = requestFactory.makeBasketRequestFactory()
        let expecation = expectation(description: "Payed")
        basket.payBasket(creditCard: card, productId: id) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "\(sum)rub. списано с карты \(card).")
                XCTAssertEqual(model.errorMessage, nil)
                expecation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expecation], timeout: 10.0)
    }



}
