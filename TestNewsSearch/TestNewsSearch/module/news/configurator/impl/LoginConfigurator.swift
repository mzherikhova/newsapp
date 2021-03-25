//
//  LoginItemConfigurator.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 23.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit

class LoginConfigurator: IConfigurator {
    static let shared = LoginConfigurator()
    private init() {}

    func initialize(_ data: Any?) -> UIViewController {
        let vc = LoginViewController()
        let presenter = LoginPresenter(view: vc)
        presenter.router = Router(view: vc)
        vc.presenter = presenter
        return vc
    }
}
