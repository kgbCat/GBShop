//
//  ErrorParser.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
