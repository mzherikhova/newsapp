//
//  INewsItemPresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 20.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INewsItemPresenter: IPresenter {
    var newsItem: NewsItem? { get set }
    func setupContent()

    func updateFavorite()

}
