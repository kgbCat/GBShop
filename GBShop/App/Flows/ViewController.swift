//
//  ViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    let requestFactory = RequestFactory()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue


        auth(request: AuthRequest(userName: "delova", password: "12345"))
        logout(request: LogoutRequest(id: 123))

        register(user: UserDataRequest(id: 1, userName: "delova",
                                       password: "12345", email: "delova@mail.ru",
                                       gender: "f", creditCard: "1234564785869",
                                       bio: "jahfgyaef"))
        changeUsersData(user: UserDataRequest(id: 123, userName: "Somebody",
                                              password: "mypassword", email: "some@some.ru",
                                              gender: "m", creditCard: "9872389-2424-234224-234",
                                              bio: "This is good! I think I will switch to another language"))

        getCategory(pageNumber: 1, idCategory: 1)

        getProductByID(id: 123)



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
