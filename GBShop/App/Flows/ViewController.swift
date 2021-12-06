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


//        auth(userName: "Somebody", password: "mypassword")
//        logout(id: 123)
//        register(user: UserDataRequest(id: 123, userName: "Somebody",
//                                       password: "mypassword", email: "some@some.ru",
//                                       gender: "m", creditCard: "9872389-2424-234224-234",
//                                       bio: "This is good! I think I will switch to another language"))
//        changeUsersData(user: UserDataRequest(id: 123, userName: "Somebody",
//                                              password: "mypassword", email: "some@some.ru",
//                                              gender: "m", creditCard: "9872389-2424-234224-234",
//                                              bio: "This is good! I think I will switch to another language"))
        
        getCategory(pageNumber: 1, idCategory: 1)
        getProductByID(id: 123)



        // Do any additional setup after loading the view.
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
    func auth(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: userName , password: password) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func logout(id: Int) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logOut(id: id) { response in
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
