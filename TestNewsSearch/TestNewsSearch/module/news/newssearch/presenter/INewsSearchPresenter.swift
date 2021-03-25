//
//  INewsSearchView.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INewsSearchPresenter: IPresenter {
    var retrievedData: [NewsItem] { get set }

    func loadSearchHistory()
    func searchWithQuery(query: String)
    func searchSavedRequest(index: Int)
     func searchNews(query: String, withRefresh: Bool)
    func getNextSearch()
    func selectItem(index: Int)
}
