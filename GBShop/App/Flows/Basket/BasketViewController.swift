//
//  BasketViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/29/21.
//

import UIKit

class BasketViewController: UIViewController {

    let requestFactory = RequestFactory()
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        payBasket(productId: 123, creditCard: "12345678")
        addItem(productId: 123)
        deleteItem(productId: 123)
    }
}
extension BasketViewController {

    func payBasket(productId: Int, creditCard: String) {
        let request = requestFactory.makeBasketRequestFactory()
        request.payBasket(creditCard: creditCard, productId: productId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func addItem(productId: Int) {
        let request = requestFactory.makeBasketRequestFactory()
        request.addItemToBasket(productId: productId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func deleteItem(productId: Int) {
        let request = requestFactory.makeBasketRequestFactory()
        request.deleteItemFromBasket(productId: productId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

