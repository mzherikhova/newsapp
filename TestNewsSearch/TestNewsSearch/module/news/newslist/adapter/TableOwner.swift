//
//  TableOwner.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol TableOwner: class {
    func reloadData()
    func selectedItem(index: Int)
    func actionSelectedInRow(index: Int)

}

protocol ScrollingListener: class {
    func scrolledBottom()
}
