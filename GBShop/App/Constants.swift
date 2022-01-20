//
//  Constants.swift
//  GBShop
//
//  Created by Anna Delova on 12/12/21.
//

import Foundation

class Constants {

    static var sharedUser = Constants(user: UserDataRequest(userName: "", password: "", email: "", creditCard: ""))
    var user: UserDataRequest
    
    private init(user: UserDataRequest) {
        self.user = user
    }

    static let baseUrl = "https://nameless-woodland-06741.herokuapp.com/"

    //MARK: Segue identifires

    static let goToRegisterVC = "goToRegisterVC"
    static let goToCatalogVC = "goToCatalogVC"
    static let goToChangeRegistrationVC = "goToChangeRegistrationVC"
    static let registerThenUnwindToLogin  = "registerThenUnwindToLogin"
    static let unwindToLogin  = "unwindToLogin"
    static let goToReviewController = "goToReviewController"
    static let goToBasketController = "goToBasketController"

    //MARK: Cell identifires

    static let productCell = "productCell"

    //MARK: nib names

    static let CatalogTableViewCell = "CatalogTableViewCell"


}
