//
//  GBShopTests.swift
//  GBShopTests
//
//  Created by Anna Delova on 11/26/21.
//

import XCTest
import Alamofire
@testable import GBShop

class LoginLogoutTests: XCTestCase {

    var requestFactory: RequestFactory!

    override func setUp()  {

        requestFactory = RequestFactory()
    }

    override func tearDown() {
        requestFactory = nil

    }

    func testLogoutResult() {

        let auth = requestFactory.makeAuthRequestFatory()
        let logoutExpectation = expectation(description: "loged out")

        auth.logOut(id: 123) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
                logoutExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [logoutExpectation], timeout: 10.0)


    }
    func testAuthResult()  {

        let auth = requestFactory.makeAuthRequestFatory()
        let authExpectation = expectation(description: "loged in")
        auth.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.user.id, 123)
                XCTAssertEqual(model.user.login, "geekbrains")
                XCTAssertEqual(model.user.name, "John")
                XCTAssertEqual(model.user.lastName, "Doe")

                authExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [authExpectation], timeout: 10.0)
    }

}
