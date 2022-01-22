//
//  AnalyticsManager.swift
//  GBShop
//
//  Created by Anna Delova on 1/21/22.
//

import Foundation
import FirebaseAnalytics

class AnalyticsManager {
    static let shared: AnalyticsManager = AnalyticsManager()
    private init() {}
}

extension AnalyticsManager {

    func trackSignIn(_ method: String) {
        Analytics.logEvent("sign_in", parameters: [
            AnalyticsParameterMethod: method
        ])
    }
    func trackSignInFail(_ method: String) {
        Analytics.logEvent("login_fail", parameters: [
            AnalyticsParameterMethod: method
        ])
    }
    func trackLogout(_ method: String) {
        Analytics.logEvent("logout", parameters: [
            AnalyticsParameterMethod: method
        ])
    }
    func trackSignUp(_ method: String) {
        Analytics.logEvent("sign_up", parameters: [
            AnalyticsParameterMethod: method
        ])
    }
    func trackRemoveFromCart(itemId: Int) {
        Analytics.logEvent("remove_from_cart", parameters: [
            "item_id": itemId
        ])
    }
    func trackPurchase(_ method: String) {
        Analytics.logEvent("purchase", parameters: [
            AnalyticsParameterMethod: method
        ])
    }
}
