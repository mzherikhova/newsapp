//
//  NewsListConfiguratore.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: Initializer for news list screen
class NewsListConfigurator: IConfigurator {
    static let shared = NewsListConfigurator()
    private init() {}

    func initialize(_ data: Any?) -> UIViewController {
        let vc = NewsListViewController()
        let presenter = NewsPresenter(view: vc)
        presenter.router = Router(view: vc)
        vc.newsPresenter = presenter
        return vc
    }
}
