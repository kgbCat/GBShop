//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import Foundation
import Alamofire

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
