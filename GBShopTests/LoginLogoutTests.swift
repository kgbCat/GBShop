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
        let mockRequest = LogoutRequest(id: 1)
        let auth = requestFactory.makeAuthRequestFatory()
        let logoutExpectation = expectation(description: "loged out")
        auth.logOut(request: mockRequest) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 0)
                XCTAssertEqual(model.userMessage, "Не верный ID пользователя")
                XCTAssertEqual(model.errorMessage, nil)
                logoutExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [logoutExpectation], timeout: 10.0)
    }
    func testAuthResult()  {
        let mockRequest = AuthRequest(userName: "delova", password: "123456")
        let auth = requestFactory.makeAuthRequestFatory()
        let authExpectation = expectation(description: "loged in")
        auth.login(request: mockRequest) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
//                XCTAssertEqual(model.result, 0)
                XCTAssertEqual(model.userMessage, "Вход выполнен!")
//                XCTAssertEqual(model.userMessage, "Ошибка ввода данных пользователя")
//                XCTAssertEqual(model.userMessage, "Неверный пароль!")

                XCTAssertEqual(model.errorMessage, nil)
                authExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [authExpectation], timeout: 10.0)
    }

    func testRegisterUser() {
        let mockRequest = UserDataRequest(id: 1, userName: "delova", password: "123456", email: "delova@", gender: "f", creditCard: "1234567890", bio: "sdfg")
        let registration = requestFactory.makeUserDataRequestFatory()
        let expectation = expectation(description: "Registered")
        registration.register(user: mockRequest) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Регистрация прошла успешно!")
                XCTAssertEqual(model.errorMessage, nil)

                expectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testChangeUserData() {

        let mockRequest = UserDataRequest(id: 1, userName: "delova", password: "123456", email: "delova@", gender: "f", creditCard: "1234567890", bio: "sdfg")
        let changeData = requestFactory.makeUserDataRequestFatory()
        let expectation = expectation(description: "Registered")
        changeData.changeData(user: mockRequest) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Данные изменены успешно!")
                XCTAssertEqual(model.errorMessage, nil)

                expectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)

    }



}
