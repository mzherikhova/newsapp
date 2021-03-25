//
//  ISignUpPresenter.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 25.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpPresenter: ISignUpPresenter {
    
    var router: Router?
    weak var view: ISignupView?
    
    
    init(view: ISignupView) {
        self.view = view
    }
    
    func signUpFirebase(email: String, password: String) {
        // Signing in the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // Couldn't sign in
                self.view?.showError(error: error)
            }
            else {
                self.view?.showDialog(message: "Пользователь создан", nil, nil)
            }
        }
    }
}
