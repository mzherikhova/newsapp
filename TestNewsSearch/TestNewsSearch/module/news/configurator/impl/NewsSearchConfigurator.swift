//
//  NewsSearchConfigurator.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsSearchConfigurator: IConfigurator {
    static let shared = NewsSearchConfigurator()
    private init() {}

    func initialize(_ data: Any?) -> UIViewController {
        let vc = NewsSearchViewController()
        let presenter = NewsSearchPresenter(view: vc)
        presenter.router = Router(view: vc)
        vc.presenter = presenter
        vc.input(data: data)
        return vc
    }
}
