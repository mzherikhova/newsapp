//
//  MoviesListViewController.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsListViewController: BaseViewController, INewsListView {

var newsPresenter: INewsPresenter?
    @IBOutlet weak var newsList: RefreshableCollectionView!
    @IBOutlet weak var emptyResultLabel: UILabel!

    var source: NewsSource?
    var searchButton: UIBarButtonItem?
    var favoriteButton: UIBarButtonItem?

    private var firstLoad: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        newsList.register(UINib(nibName: NewsListCell.cellId, bundle: nil), forCellWithReuseIdentifier: NewsListCell.cellId)
        newsList.register(UINib(nibName: LoadingFooter.cellId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooter.cellId )
        newsList.listener = self
       setupMenu()
          source = NewsSource()
        newsPresenter?.getNews(withRefresh: true)
    }

    private func setupMenu() {
        searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(openSearch))

        favoriteButton = UIBarButtonItem(image: UIImage(named: "favorite"), style: .plain, target: self, action: #selector(openFavorite))
        if let sb = searchButton, let fb = favoriteButton {
            self.navigationItem.rightBarButtonItems = [sb, fb]
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Новости"
        if (!firstLoad) {
            newsPresenter?.synchronizeFavorite()
        }
        firstLoad = false

        source?.owner = self
        source?.scrollListener = self
        newsList.dataSource = source
        newsList.delegate = source
    }

    override func viewWillDisappear(_ animated: Bool) {
        source?.owner = nil
        source?.scrollListener = nil
        newsList.dataSource = nil
        newsList.delegate = nil
        super.viewWillDisappear(animated)
    }

    func setupNews(news: [NewsItem]) {
        newsList?.endRefresh()

        source?.owner = self
        source?.scrollListener = self
        newsList.dataSource = source
        newsList.delegate = source
        source?.setupHorizontal(isHorizontal: isHorizontal)
        source?.updateItems(items: news)
        emptyResultLabel.isHidden = news.count > 0
    }

    @objc private func openSearch() {
        newsPresenter?.openSearch()
    }

    @objc private func openFavorite() {
        newsPresenter?.openFavorite()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        source?.setupHorizontal(isHorizontal: isHorizontal)
    }

    private var isHorizontal: Bool {
        get {
       return  UIDevice.current.orientation.isLandscape
        }
    }

}

extension NewsListViewController: TableOwner {
    func actionSelectedInRow(index: Int) {
        newsPresenter?.updateFavorite(index: index)
    }

    func reloadData() {
        newsList.reloadData()
    }

    func selectedItem(index: Int) {
        newsPresenter?.selectItem(index: index)
    }
}

extension NewsListViewController: ScrollingListener {

    func scrolledBottom() {
        newsPresenter?.getNews(withRefresh: false)
    }
}

extension NewsListViewController: RefreshListener {
    func updateContent() {
        newsPresenter?.getNews(withRefresh: true)
    }
}
