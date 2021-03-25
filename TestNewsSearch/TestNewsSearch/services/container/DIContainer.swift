//
//  DIContainer.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

protocol IDIContainer {
    var networkService: INetworkService { get }
    var networkConfiguration: INetworkConfiguration { get }
}

class DIContainer: IDIContainer {

    var networkConfiguration: INetworkConfiguration {
        get {
            return NetworkConfiguration()
        }
    }

    var networkService: INetworkService {
        get {
            return NetworkService(networkConfiguration: networkConfiguration)
        }
    }
}
