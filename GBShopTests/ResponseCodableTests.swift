//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Anna Delova on 12/5/21.
//


import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {

    var errorParser: ErrorParserStub!

    struct PostStub: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

    enum ApiErrorStub: Error {
        case fatalError
    }

    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }

        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }

    override func setUpWithError() throws {

        errorParser = ErrorParserStub()

    }

    override func tearDownWithError() throws {

        errorParser = nil

    }

    // MARK: - Positive tests

    func testShouldDownloadAndParse() throws {
        let expectation = XCTestExpectation(description: "Download https://jsonplaceholder.typicode.com/posts/1")

        AF.request("https://jsonplaceholder.typicode.com/posts/1").responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub, AFError>) in
            switch response.result {
            case .success(_):
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // MARK: - Negative tests



}
