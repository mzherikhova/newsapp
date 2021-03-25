//
//  INewsSearchView.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INewsSearchView: class, IInputView, IView {
    func showSearchHistory(history: [SearchItem])
    func showSearchResults(results: [NewsItem])

}
