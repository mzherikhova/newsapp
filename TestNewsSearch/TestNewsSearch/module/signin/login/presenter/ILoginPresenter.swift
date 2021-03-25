//
//  ILoginPresenter.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 23.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import Foundation

protocol ILoginPresenter: IPresenter {
    func openNewsList()
    func openSignUp()
    func authFirebase(email: String, password: String)
}
