//
//  LoadProductsTests.swift
//  GBShopTests
//
//  Created by Anna Delova on 12/5/21.
//

import XCTest
import Alamofire
@testable import GBShop

class LoadProductsTests: XCTestCase {

    var requestFactory: RequestFactory!

    override func setUp()  {

        requestFactory = RequestFactory()
    }

    override func tearDown() {
        requestFactory = nil

    }
    // MARK: - Positive tests
    func testgetCatalogData() throws {
        let request = requestFactory.makeProductRequestFactory()
        let expectation = expectation(description: "Catalog data")
        request.getCatalogData(pageNumber: 1, idCategory: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.count, 2)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 15.0)
    }

    func testGetProductByID() {
        let request = requestFactory.makeProductRequestFactory()
        let expectation = expectation(description: "Product is loaded")
        request.getProductByID(id: 123) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
                XCTAssertEqual(result.name, "Ноутбук")
                XCTAssertEqual(result.price, 45600)
                XCTAssertEqual(result.description, "Мощный игровой ноутбук")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    // MARK: - Negative tests

    func testFailGetProductByID() {
        let request = requestFactory.makeProductRequestFactory()
        let expectation = expectation(description: "Product is loaded")
        request.getProductByID(id: 45) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
                XCTAssertEqual(result.name, "Ноутбук")
                XCTAssertEqual(result.price, 45600)
                XCTAssertEqual(result.description, "Мощный игровой ноутбук")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
