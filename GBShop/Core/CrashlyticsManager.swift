//
//  CrashlyticsManager.swift
//  GBShop
//
//  Created by Anna Delova on 1/22/22.

import Foundation
import FirebaseCrashlytics

class CrashlyticsManager {
    static let shared: CrashlyticsManager = CrashlyticsManager()
    private init() {}
}

enum Domain: String  {
    case auth = "Auth: post/api/AuthRequest failure"
    case registerCrash = "Register:post/api/UserDataRequest failure"
    case changeDataCrash  = "ChangeUsersData: post/api/Failed to change Users data"
    case getProducts = "GetCategory: poost/api/Failed to load products data"
    case logoutCrash = "Logout: post/api/Failed to logout"
}

enum CodeError: Int {
    case authError = 100
    case getProdutsError = 200
    case logoutError = 300
    case changeUsersDataError = 400
    case registerError = 500
}

extension CrashlyticsManager {

    func crash(domain: String, code: Int) {

        let error = NSError(domain: domain, code: code)
        Crashlytics.crashlytics().record(error: error)
    }
}
