//
//  NewsPresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsPresenter: INewsPresenter {

  var router: Router?

   weak var view: INewsListView?
   private let newsService: INewsService

    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0

    private var news: [NewsItem] = [NewsItem]()

    init(view: INewsListView) {
        self.view = view
        self.newsService = DI.serviceContainer.newsService
    }

    func getNews(withRefresh: Bool) {
        if (withRefresh) {
            page = 0
            total = 0
            news = [NewsItem]()
        } else {
            guard news.count < total else {
                return
            }
        }
        newsService.getNewsList(page: page) { [weak self]
            response in
            if let error = response.error {
                self?.view?.showError(error: error)
            } else {
                if let data = response.content {
                    self?.total = data.total

                    let loaded = data.articles ?? [NewsItem]()
                    if loaded.count > 0 {
                        self?.page += 1
                        self?.news.append(contentsOf: loaded)
                        self?.view?.setupNews(news: self?.news ?? [NewsItem]())
                    }
                }

            }
        }
    }

    func synchronizeFavorite() {
      news = newsService.syncWithFavorite(loadedNews: news)
      view?.setupNews(news: news)
    }

    func updateFavorite(index: Int) {
       let item = news[index]
        item.favorite = !item.favorite
        if (item.favorite) {
            addToFavorite(newsItem: item)
        } else {
            removeFromFavorite(newsItem: item)
        }
        DispatchQueue.main.async {
            self.view?.setupNews(news: self.news )
        }
    }

    private func addToFavorite(newsItem: NewsItem) {
        newsService.addToFavorite(newsItem: newsItem)
    }

    private func removeFromFavorite(newsItem: NewsItem) {
        newsService.removeFromFavorite(newsItem: newsItem)
    }

    func selectItem(index: Int) {
        let item = news[index]
        router?.navigateTo(screen: .NewsItem, item)
    }

    func openFavorite() {
        router?.navigateTo(screen: .Favorite)
    }
    func openSearch() {
        router?.navigateTo(screen: .Search, news)
    }

}
