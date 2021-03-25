//
//  NewsSearchPresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsSearchPresenter: INewsSearchPresenter {

   var newsService: INewsService?
    weak var view: INewsSearchView?

    var retrievedData: [NewsItem] = [NewsItem]()
    var searchHistory: [SearchItem] = [SearchItem]()
    var foundResults: [NewsItem] = [NewsItem]()

    private var query = ""
    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0

    var router: Router?

    init(view: INewsSearchView) {
        self.view = view
         self.newsService = DI.serviceContainer.newsService
    }

    func loadSearchHistory() {
        newsService?.getRecentRequests { [weak self] results in
            self?.searchHistory = results
            self?.view?.showSearchHistory(history: self?.searchHistory ?? [SearchItem]())
        }
    }
    func searchWithQuery(query: String) {
        if query.isEmpty {
            view?.showSearchHistory(history: searchHistory)

        } else {
            searchHistory.insert(SearchItem(title: query), at: 0)
            newsService?.saveRecentRequests(items: searchHistory)
            if query.count > 2 {
                searchNews(query: query, withRefresh: true)
            } else {
                searchLocal(query: query)
            }
        }
    }

    func searchNews(query: String, withRefresh: Bool) {
        if (withRefresh) {
            self.query = query
            self.page = 0
            self.total = 0
        } else {
            guard foundResults.count < total else {
                return
            }
        }
    newsService?.searchNews(query: query, page: self.page) {[weak self]
        response in
        if let error = response.error {
           self?.view?.showError(error: error)
        } else {
            if let data = response.content {
                self?.total = data.articles?.count ?? 0
                let results = data.articles ?? [NewsItem]()
                if results.count > 0 {
                    self?.page += 1

                }
                self?.foundResults.append(contentsOf: results)
                self?.view?.showSearchResults(results: results)
            }
        }
    }
    }

    func getNextSearch() {
        if !self.query.isEmpty {
            self.searchNews(query: self.query, withRefresh: false)
        }
    }

    private func searchLocal(query: String) {
        foundResults = retrievedData.filter {($0.title ?? "").contains(query)}
        view?.showSearchResults(results: foundResults)
    }

    func searchSavedRequest(index: Int) {
        if let query = searchHistory[index].title {
        if (query.count > 2) {
            searchNews(query: query, withRefresh: true)
        } else {
       searchLocal(query: query)
        }
        }
    }

    func selectItem(index: Int) {
        let item = foundResults[index]
        router?.navigateTo(screen: .NewsItem, item)
    }

}
