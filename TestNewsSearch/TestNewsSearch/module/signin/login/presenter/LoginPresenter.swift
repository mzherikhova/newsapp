//
//  LoginPresenter.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 23.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginPresenter: ILoginPresenter {
    
    var router: Router?
    weak var view: ILoginView?
    
    init(view: ILoginView) {
        self.view = view
    }
    
    func openNewsList() {
        router?.navigateTo(screen: .NewsList)
    }
    
    func openSignUp() {
        router?.navigateTo(screen: .SignUp)
    }
    
    func authFirebase(email: String, password: String) {
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                // Couldn't sign in
                self.view?.showError(error: error)
            }
            else {
                self.openNewsList()
            }
        }
    }
}

