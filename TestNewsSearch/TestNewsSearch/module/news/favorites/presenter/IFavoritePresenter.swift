//
//  IFavoritePresenter.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol IFavoritePresenter: IPresenter {
    func getFavorite()
    func selectItem(index: Int)
    func updateFavorite(index: Int)
}
