//
//  INewsPresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INewsPresenter: IPresenter {

    func getNews(withRefresh: Bool)
    func selectItem(index: Int)

    func updateFavorite(index: Int)
    func synchronizeFavorite()

    func openFavorite()
    func openSearch()
}
