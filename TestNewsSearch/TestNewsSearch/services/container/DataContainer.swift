//
//  DataContainer.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: DI for dao
protocol IDataContainer {
    var favoriteDao: FavoriteProvider {get}
    var searchDao: SearchProvider { get }
}

class DataContainer: IDataContainer {
    var favoriteDao: FavoriteProvider {
        get {
            return FavoriteProvider()
        }
    }

    var searchDao: SearchProvider {
        get {
            return SearchProvider()
        }
    }
}
