//
//  ReviewViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/29/21.
//

import UIKit

class ReviewViewController: UIViewController {

    let requestFactory = RequestFactory()
    var newReview: Review?
    var productId = Int()
    var randomInt = Int()


    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var starCountTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        randomInt = Int.random(in: 4..<100)
    }

    @IBAction func doneButton(_ sender: UIButton) {
        newReview = Review(
            customerName: customerNameTextField.text!,
            productId: productId,
            starCount: Int(starCountTextField.text!) ?? 0,
            review: reviewTextField.text!,
            reviewId: randomInt)
        if let review = newReview {
            addReview(review: review)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.unwindForProductVC {
            let productCV: ProductViewController = segue.destination as! ProductViewController
            if let newReview = newReview {
                productCV.reviews.append(newReview)
                productCV.reviewTableView.reloadData()
            }
        }
    }
}
extension ReviewViewController {
    func addReview(review: Review) {
        let request = requestFactory.makeReviewRequestFactory()
        request.addNewReview(review: review) { response in
            DispatchQueue.main.async {
                switch response.result{
                    case .success(let result):
                    if result.result == 1 {
                        print(result.userMessage)
                        self.performSegue(withIdentifier: Constants.unwindForProductVC, sender: self)
                    } else {
                        print(result.userMessage)
                    }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}

 // pass new review to ProductVC ( reload Tableview)

