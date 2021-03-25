//
//  FavoriteConfigurator.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class FavoriteConfigurator: IConfigurator {
    static let shared = FavoriteConfigurator()
    private init() {}

    func initialize(_ data: Any?) -> UIViewController {
        let vc = FavoriteNewsController()
        let presenter = FavoritePresenter(view: vc)
        presenter.router = Router(view: vc)
        vc.favoritePresenter  = presenter
        return vc
    }
}
