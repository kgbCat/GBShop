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
                XCTAssertEqual(result.count, 5)
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
        request.getProductByID(id: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
                XCTAssertEqual(result.name, "MSI / Ноутбук MSI GF63")
                XCTAssertEqual(result.price, 82694)
                XCTAssertEqual(result.description, "Thin 11UC-219XRU 15.6 FHD/i5-11400H/8Gb/512Gb SSD/RTX3050 4Gb, DOS, черный")
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
                XCTAssertEqual(result.result, 0)
                XCTAssertEqual(result.name, "")
                XCTAssertEqual(result.price, 0)
                XCTAssertEqual(result.description, "Такого товара нет")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
