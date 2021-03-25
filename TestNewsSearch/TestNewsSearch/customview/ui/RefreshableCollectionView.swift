//
//  RefreshableCollectionView.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import UIKit

protocol RefreshListener: class {
    func updateContent()
}

class RefreshableCollectionView: UICollectionView {

    weak var listener: RefreshListener?

    var isRefreshing: Bool {
        get {
            return self.refresh.isRefreshing
        }
    }

    private let refresh: UIRefreshControl = UIRefreshControl()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContent()
    }

   private func initContent() {
      if #available(iOS 10.0, *) {
            self.refreshControl = refresh
        } else {
            self.addSubview(refresh)
        }
        refresh.addTarget(self, action: #selector(beginUpdate(_:)), for: .valueChanged)
    }

    @objc private func beginUpdate(_ sender: Any) {
        self.listener?.updateContent()
    }

    func endRefresh() {
        self.refresh.endRefreshing()
    }

    deinit {
        refresh.removeTarget(self, action: #selector(beginUpdate(_:)), for: .valueChanged)
    }

}
