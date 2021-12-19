//
//  RequestFactory.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

class RequestFactory {

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeUserDataRequestFatory() -> UserRequestFactory {
        let errorParser = makeErrorParser()
        return UserData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeProductRequestFactory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
        return ProductData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeReviewRequestFactory() -> ReviewRequestFactory {
        let errorParser = makeErrorParser()
        return ReviewData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeBasketRequestFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return BasketData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}


