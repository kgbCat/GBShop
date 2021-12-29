//
//  ViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {

    let requestFactory = RequestFactory()

    // MARK: IBoutlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


//        payBasket(productId: 123, creditCard: "12345678")
//        addItem(productId: 123)
//        deleteItem(productId: 123)

//        deleteReview(reviewId: 3)
//        getReviews(productId: 123)
//        addReview(review: Review(customerName: "Anna", productName: "Macbook", starCount: 5, review: "nice", reviewId: 3))

//        auth(request: AuthRequest(userName: "delova", password: "123456"))
//        logout(request: LogoutRequest(id: 1))
////
//        register(user: UserDataRequest(id: 1, userName: "delova",
//                                       password: "123456", email: "delova@mail.ru",
//                                       gender: "f", creditCard: "1234564785869",
//                                       bio: "jahfgyaef"))

//        changeUsersData(user: UserDataRequest(id: 1, userName: "delova",
//                                              password: "123456", email: "delova@mail.ru",
//                                              gender: "f", creditCard: "12345647859",
//                                              bio: "jahfgyaef"))
//
//        getCategory(pageNumber: 1, idCategory: 1)
//        getProductByID(id: 123)

    }
    // MARK: IBActions

    @IBAction func toSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToRegisterVC, sender: self)

    }
    @IBAction func toSignIn(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToCatalogVC, sender: self)
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }


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

    func getReviews(productId: Int) {
        let request = requestFactory.makeReviewRequestFactory()
        request.getAllReviews(productId: productId) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
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

    func addReview(review: Review) {
        let request = requestFactory.makeReviewRequestFactory()
        request.addNewReview(review: review) { response in
            switch response.result{
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func getCategory(pageNumber: Int, idCategory: Int) {
        let request = requestFactory.makeProductRequestFactory()
        request.getCatalogData(pageNumber: pageNumber, idCategory: idCategory ) { response in
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


    func changeUsersData(user:UserDataRequest) {
        let newUser = requestFactory.makeUserDataRequestFatory()
        newUser.changeData(user: user) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func register(user:UserDataRequest) {
        let newUser = requestFactory.makeUserDataRequestFatory()
        newUser.register(user: user) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func auth(request: AuthRequest) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(request: request) { response in
            switch response.result {
            case .success(let login):
                print(login)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
