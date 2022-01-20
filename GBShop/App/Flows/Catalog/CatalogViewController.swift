//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/27/21.
//

import UIKit

class CatalogViewController: UIViewController {

    var data = [Product]()
    var id = Int()
    let requestFactory = RequestFactory()
    var product: Product?

    @IBOutlet weak var catalogTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.catalogTableView.delegate = self
        self.catalogTableView.dataSource = self
        self.catalogTableView.register(UINib(nibName: Constants.CatalogTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.productCell)

        getCategory(pageNumber: 1, idCategory: 1)
    }

    //MARK: Navigation
    @IBAction func toChangeUserProfile(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToChangeRegistrationVC, sender: self)
    }

    @IBAction func logout(_ sender: UIBarButtonItem) {
        logout(request: LogoutRequest(userName: Constants.sharedUser.user.userName))
    }
}
    //MARK: TableView DataSource
extension CatalogViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = catalogTableView.dequeueReusableCell(withIdentifier: Constants.productCell,
                                                           for: indexPath) as? CatalogTableViewCell {
            cell.configer(product: data[indexPath.row])
            cell.catalogDelegate = self
            
            return cell
        }
        return UITableViewCell()
    }
}
    //MARK: Delegates
extension CatalogViewController: UITableViewDelegate, CatalogCellDelegate {

    func didTapAddToTheCart(product: Product) {
        performSegue(withIdentifier: Constants.goToBasketController, sender: product)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToBasketController {
            let basketController: BasketViewController = segue.destination as! BasketViewController
            basketController.product = sender as? Product
        }
        if segue.identifier == Constants.goToProductVC {
            let productController: ProductViewController = segue.destination as! ProductViewController
            if let  product = self.product {
                productController.product =  product
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.product = data[indexPath.row]
        performSegue(withIdentifier: Constants.goToProductVC, sender: indexPath.row)
    }
}

extension CatalogViewController {

    //MARK: API methods
    func getCategory(pageNumber: Int, idCategory: Int) -> Void {
        let request = requestFactory.makeProductRequestFactory()
        request.getCatalogData(pageNumber: pageNumber, idCategory: idCategory ) { response in
            DispatchQueue.main.async {
                switch response.result{
                case .success(let result):
                    self.data = result
                    self.data.sort(by:{ $0.id < $1.id })
                    self.catalogTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    func logout(request: LogoutRequest)  {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logOut(request: request) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let logout):
                    self.showAlert(message: logout.userMessage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.performSegue(withIdentifier: Constants.unwind, sender: self)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    //MARK: Private methods
    private func showAlert(message: String = "!") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
