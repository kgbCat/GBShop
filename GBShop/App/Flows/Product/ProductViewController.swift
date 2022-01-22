//
//  ProductViewController.swift
//  GBShop
//
//  Created by Anna Delova on 1/14/22.
//

import UIKit

class ProductViewController: UIViewController {

    let requestFactory = RequestFactory()
    var product: Product!
    var reviews = [Review]()

    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var productNameLbl: UILabel! { didSet {productNameLbl.text = product.name}}
    @IBOutlet weak var priceLabel: UILabel! { didSet {priceLabel.text = "\(product.price) rub"}}
    @IBOutlet weak var producDescriptionLbl: UILabel! { didSet {producDescriptionLbl.text = product.description}}


    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: Constants.ReviewTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.reviewCell)
        getReviews(productId: product.id)
    }

    @IBAction func addReviewButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToReviewController, sender: sender)
    }
    @IBAction func unwind( _ seg: UIStoryboardSegue) { }
}
extension ProductViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = reviewTableView
            .dequeueReusableCell(withIdentifier: Constants.reviewCell,
                                 for: indexPath) as? ReviewTableViewCell {
            cell.configer(review: reviews[indexPath.row])
            return cell
        }
        CrashlyticsManager.shared.crash(domain: Domain.auth.rawValue
                                        ,code: CodeError.authError.rawValue)
        return UITableViewCell()
    }
}
extension ProductViewController: UITableViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToReviewController {
            let reviewController: ReviewViewController = segue.destination as! ReviewViewController
            reviewController.productId = product.id
        }
    }
}
extension ProductViewController {

    //MARK: API methods
    func getReviews(productId: Int) {
        let request = requestFactory.makeReviewRequestFactory()
        request.getAllReviews(productId: productId) { response in
            DispatchQueue.main.async {
                switch response.result{
                    case .success(let result):
                        self.reviews = result
                        self.reviewTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    func deleteReview(reviewId: Int) {
        let request = requestFactory.makeReviewRequestFactory()
        request.deleteReview(reviewId: reviewId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
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
}
