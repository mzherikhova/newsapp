//
//  FavoritePresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class FavoritePresenter: IFavoritePresenter {
    var favorites: [NewsItem] = [NewsItem]()

    var router: Router?

    weak var view: IFavoriteView?
    private let newsService: INewsService

    init(view: IFavoriteView) {
        self.view = view
        self.newsService = DI.serviceContainer.newsService
    }

    func getFavorite() {
      favorites =  newsService.getFavorites()
       view?.setupFavoriteNews(news: favorites)
    }

    func updateFavorite(index: Int) {
         let item = favorites[index]
        item.favorite = !item.favorite

        if (item.favorite) {
            addToFavorite(newsItem: item)
        } else {
            removeFromFavorite(newsItem: item)
        }

        getFavorite()
    }

    private func addToFavorite(newsItem: NewsItem) {
        newsService.addToFavorite(newsItem: newsItem)
    }

    private func removeFromFavorite(newsItem: NewsItem) {
        newsService.removeFromFavorite(newsItem: newsItem)
    }

    func selectItem(index: Int) {
        let item = favorites[index]
        router?.navigateTo(screen: .NewsItem, item)
    }

}
