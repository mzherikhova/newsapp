//
//  SignUpConfigurator.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 25.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit

class SignUpConfigurator: IConfigurator {
    static let shared = SignUpConfigurator()
    private init() {}

    func initialize(_ data: Any?) -> UIViewController {
        let vc = SignUpViewController()
        let presenter = SignUpPresenter(view: vc)
        presenter.router = Router(view: vc)
        vc.presenter = presenter
        return vc
    }
}
