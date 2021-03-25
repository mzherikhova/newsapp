//
//  NewsItemPresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 20.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsItemPresenter: INewsItemPresenter {
   var router: Router?

    var newsItem: NewsItem?

    let newsService: INewsService
    weak var view: INewsView?

    init(view: INewsView) {
        self.view = view
        self.newsService = DI.serviceContainer.newsService
    }

    func setupContent() {
        if let item = newsItem {
        view?.setupItem(newsItem: item)
        }
    }

    func updateFavorite() {
       let favorite = newsItem?.favorite ?? false
       newsItem?.favorite = !favorite

        if (!favorite) {
            addToFavorite()
        } else {
            removeFromFavorite()
        }
        view?.updateFavorite(isFavorite: !favorite)
    }

    private func addToFavorite() {
        guard let item = newsItem else { return }
        newsService.addToFavorite(newsItem: item)
    }

    private func removeFromFavorite() {
        guard let item = newsItem else { return }
        newsService.removeFromFavorite(newsItem: item)
    }
}
