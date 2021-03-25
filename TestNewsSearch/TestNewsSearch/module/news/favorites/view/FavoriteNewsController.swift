//
//  FavoriteNewsController.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class FavoriteNewsController: BaseViewController, IFavoriteView {

    var favoritePresenter: IFavoritePresenter?
    @IBOutlet weak var emptyResultLabel: UILabel!
    @IBOutlet weak var favoriteList: UICollectionView!
    var source: NewsSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteList.register(UINib(nibName: NewsListCell.cellId, bundle: nil), forCellWithReuseIdentifier: NewsListCell.cellId)
        favoriteList.register(UINib(nibName: LoadingFooter.cellId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooter.cellId )
        source = NewsSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Избранное"
        favoriteList.delegate = source
        favoriteList.dataSource = source
        source?.owner = self
        favoritePresenter?.getFavorite()
    }

    override func viewWillDisappear(_ animated: Bool) {
        favoriteList.delegate = nil
        favoriteList.dataSource = nil
        source?.owner = nil
        super.viewWillDisappear(animated)
    }

    func setupFavoriteNews(news: [NewsItem]) {
        emptyResultLabel.isHidden = news.count > 0
        source?.updateItems(items: news)
    }
}
    extension FavoriteNewsController: TableOwner {
        func actionSelectedInRow(index: Int) {
            favoritePresenter?.updateFavorite(index: index)
        }

        func scrolledBottom() {
        }

        func reloadData() {
            favoriteList.reloadData()
        }

        func selectedItem(index: Int) {
            favoritePresenter?.selectItem(index: index)
        }
    }
