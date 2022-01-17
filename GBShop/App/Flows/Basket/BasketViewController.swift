//
//  BasketViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/29/21.
//

import UIKit

class BasketViewController: UIViewController {

    let requestFactory = RequestFactory()
    var products = [Product]()
    var totalSum = 0

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.dataSource = self
        basketTableView.register(UINib(nibName: Constants.BasketTableViewCell, bundle: nil),
                                 forCellReuseIdentifier: Constants.cartCell)
    }
    override func viewWillAppear(_ animated: Bool) {
        countTotal()
        basketTableView.reloadData()
    }

    @IBAction func paymentButton(_ sender: UIButton) {
        payBasket(totalSum: totalSum, creditCard: Constants.sharedUser.user.creditCard)
    }

    @IBAction func addMore(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.addMoreFromCatalog, sender: self)
    }
}
extension BasketViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = basketTableView
            .dequeueReusableCell(withIdentifier: Constants.cartCell,
                                 for: indexPath) as? BasketTableViewCell {
            cell.configer(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // remove the item from the data model
            products.remove(at: indexPath.row)
            // delete the table view row
            basketTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
extension BasketViewController {

    func payBasket(totalSum: Int, creditCard: String) {
        let request = requestFactory.makeBasketRequestFactory()
        request.payBasket(creditCard: creditCard, totalSum: totalSum) { response in
            DispatchQueue.main.async {
                switch response.result{
                    case .success(let result):
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showAlert(message: result.userMessage)
                        }
                        self.performSegue(withIdentifier: Constants.addMoreFromCatalog, sender: self)
                    case .failure(let error):
                        print(error.localizedDescription)
                }
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
    private func countTotal() {
        self.products.forEach { product in
            self.totalSum += product.price
        }
        totalLabel.text = "Subtotal \(products.count) items: \(self.totalSum) rub "
    }
    private func showAlert(message: String = "!") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

