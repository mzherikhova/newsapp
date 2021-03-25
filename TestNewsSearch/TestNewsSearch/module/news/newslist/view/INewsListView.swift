//
//  INewsListView.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

protocol INewsListView: class, IView {
    func setupNews(news: [NewsItem])
}
