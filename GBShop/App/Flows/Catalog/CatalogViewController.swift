//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/27/21.
//

import UIKit

class CatalogViewController: UIViewController {

    var data = [Product]()
    var reviews =  [Review]()

    let requestFactory = RequestFactory()

    @IBOutlet weak var catalogTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        data.sort(by:{ $0.id < $1.id })
        reviews.sort(by: {$0.reviewId < $1.reviewId})

        self.catalogTableView.delegate = self
        self.catalogTableView.dataSource = self

        self.catalogTableView.register(UINib(nibName: Constants.CatalogTableViewCell, bundle: nil),
                                       forCellReuseIdentifier: Constants.productCell)

    }
    //MARK: Navigation
    @IBAction func toChangeUserProfile(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToChangeRegistrationVC, sender: self)
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
            cell.configer(product: data[indexPath.row], reviews: reviews[indexPath.row])
            cell.catalogDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}
    //MARK: Delegates
extension CatalogViewController: UITableViewDelegate, CatalogCellDelegate {

    func didTapReview(reviews: [Review]) {
        performSegue(withIdentifier: Constants.goToReviewController, sender: reviews)
    }

    func didTapAddToTheCart(product: Product) {
        performSegue(withIdentifier: Constants.goToBasketController, sender: product)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToReviewController {
            let reviewController: ReviewViewController = segue.destination as! ReviewViewController
            reviewController.reviews = sender as? Review
        }
        if segue.identifier == Constants.goToBasketController {
            let basketController: BasketViewController = segue.destination as! BasketViewController
            basketController.product = sender as? Product
        }
    }
}

extension CatalogViewController {

    func getCategory(pageNumber: Int, idCategory: Int) -> [Product] {
        let request = requestFactory.makeProductRequestFactory()
        var result1 = [Product]()
        request.getCatalogData(pageNumber: pageNumber, idCategory: idCategory ) { response in
            switch response.result{
            case .success(let result):
                print(result)
                result1 = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return result1
    }

    func getProductByID(id: Int) {
        let request = requestFactory.makeProductRequestFactory()
        request.getProductByID(id: id) { response in
            switch response.result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func logout(request: LogoutRequest)  {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logOut(request: request) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
