//
//  NewsItemConfigurator.swift
//  TestNewsSearch
//
//  Created by 1 on 20.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: Initializer for news item screen
class NewsItemConfigurator: IConfigurator {

static let shared = NewsItemConfigurator()
    private init() {}

func initialize(_ data: Any?) -> UIViewController {
    let vc = NewsItemController()
    let presenter = NewsItemPresenter(view: vc)
    presenter.router = Router(view: vc)
    vc.newsPresenter = presenter
    vc.input(data: data)
    return vc
}
}
