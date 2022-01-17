//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Anna Delova on 11/26/21.
//

import XCTest

class GBShopUITests: XCTestCase {
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!

    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
        scrollViewsQuery = app.scrollViews
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        enterAuthData(login: "Qwerty", mypassword: "123456")
        checkAuth(message: "Вход выполнен!")
     }
    func testFail() {
        enterAuthData(login: "user", mypassword: "password")
        checkAuth(message: "Ошибка ввода данных пользователя")
       }

    private func enterAuthData(login: String,  mypassword: String) {
        let app = XCUIApplication()

        let loginTextField  = scrollViewsQuery.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(login)
        let passwordTestField = scrollViewsQuery.textFields["password"]
        passwordTestField.tap()
        passwordTestField.typeText(mypassword)
        // to hide a keyboard
        if app.keys.element(boundBy: 0).exists {
            app.typeText("\n")
        }
        let button = scrollViewsQuery.buttons["enter"]
        button.tap()

    }
    private func checkAuth(message: String) {
        let app = XCUIApplication()
        scrollViewsQuery = app.scrollViews
        let token = addUIInterruptionMonitor(withDescription: message, handler: { alert in
            alert.buttons["Ok"].tap()
            return true
        })
        RunLoop.current.run(until: Date(timeInterval: 5, since: Date()))

        app.tap()
        removeUIInterruptionMonitor(token)

        let resultLabel = scrollViewsQuery.staticTexts[message]
        XCTAssertNotNil(resultLabel)
        XCTAssertEqual(message, resultLabel.label)

    }

}
