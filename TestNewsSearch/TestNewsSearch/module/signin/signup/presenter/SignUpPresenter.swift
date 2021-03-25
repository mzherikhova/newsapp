//
//  SignUpPresenter.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 25.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import Foundation

protocol ISignUpPresenter: IPresenter {
    func signUpFirebase(email: String, password: String)
}
