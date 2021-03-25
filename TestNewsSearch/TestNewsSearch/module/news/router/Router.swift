//
//  Router.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: Screen types for navigation
enum Screens {
    case NewsItem, Favorite, Search, NewsList, SignUp
}

// MARK: Simple router
class Router {

    weak var view: UIViewController?
    weak var navigation: UINavigationController? {
        get {
            return view?.navigationController
        }
    }

    init(view: UIViewController ) {
        self.view = view
    }

    func navigateTo(screen: Screens, _ data: Any? = nil) {
        switch screen {
        case .NewsItem:
            let vc = NewsItemConfigurator.shared.initialize(data)
            navigation?.pushViewController(vc, animated: false)
        case .Favorite:
            let vc = FavoriteConfigurator.shared.initialize(nil)
            navigation?.pushViewController(vc, animated: false)
        case .Search:
            let vc = NewsSearchConfigurator.shared.initialize(data)
            navigation?.pushViewController(vc, animated: false)
        case .NewsList:
            let vc = NewsListConfigurator.shared.initialize(data)
            navigation?.setViewControllers([vc], animated: false)
        case .SignUp:
            let vc = SignUpConfigurator.shared.initialize(data)
            navigation?.pushViewController(vc, animated: false)
        }
    }

    func back() {
        navigation?.popViewController(animated: false)
    }

}
