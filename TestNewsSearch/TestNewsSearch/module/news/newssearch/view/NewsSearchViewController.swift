//
//  NewsSearchViewController.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsSearchViewController: BaseViewController, INewsSearchView {
let search = UISearchController(searchResultsController: nil)

    @IBOutlet weak var emptyResultLabel: UILabel!
    @IBOutlet weak var searchResultList: UICollectionView!
    var historySource: SearchSource?
    var source: NewsSource?

    var historyMode: Bool = true
    var presenter: INewsSearchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = !(self.navigationController?.navigationBar.isTranslucent ?? false)
        searchResultList?.register(UINib(nibName: NewsListCell.cellId, bundle: nil), forCellWithReuseIdentifier: NewsListCell.cellId)
         searchResultList?.register(UINib(nibName: SearchCell.cellId, bundle: nil), forCellWithReuseIdentifier: SearchCell.cellId)
        searchResultList?.register(UINib(nibName: LoadingFooter.cellId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooter.cellId )

        historySource = SearchSource()
        source = NewsSource()
        setupSearch()
        presenter?.loadSearchHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Поиск"
    }

    private func setupSearch() {

        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Введите поисковый запрос"
    search.searchBar.delegate = self
       self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.titleView = search.searchBar
        self.definesPresentationContext = true
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.sizeToFit()
    }
    func showSearchHistory(history: [SearchItem]) {
        historyMode = true
        emptyResultLabel.isHidden = true
        searchResultList?.dataSource = historySource
        searchResultList?.delegate = historySource
        historySource?.owner = self
        historySource?.setupHorizontal(isHorizontal: isHorizontal)
        historySource?.updateItems(items: history)

    }
    
    func showSearchResults(results: [NewsItem]) {
        historyMode = false
        source?.owner = self
        source?.scrollListener = self
        searchResultList?.dataSource = source
        searchResultList?.delegate = source
        source?.setupHorizontal(isHorizontal: isHorizontal)
        source?.updateItems(items: results)
        searchResultList.reloadData()
        emptyResultLabel.isHidden = results.count > 0
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        source?.setupHorizontal(isHorizontal: isHorizontal)
        historySource?.setupHorizontal(isHorizontal: isHorizontal)
    }

    private var isHorizontal: Bool {
        get {
            return  UIDevice.current.orientation.isLandscape
        }
    }
}

extension NewsSearchViewController: IInputView {
    func input(data: Any?) {
        guard  let d = data as? [NewsItem] else {
            return
        }
        presenter?.retrievedData.append(contentsOf: d)
    }
}

extension NewsSearchViewController: TableOwner {
    func actionSelectedInRow(index: Int) {

    }

    func reloadData() {
        searchResultList.reloadData()
    }

    func selectedItem(index: Int) {
        if (historyMode) {
            presenter?.searchSavedRequest(index: index)
        } else {
        presenter?.selectItem(index: index)
        }
    }
}

extension NewsSearchViewController: ScrollingListener {

    func scrolledBottom() {
        presenter?.getNextSearch()
    }
}
extension NewsSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeQuery), object: nil)
        self.perform(#selector(makeQuery), with: nil, afterDelay: 0.75)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeQuery), object: nil)
        self.perform(#selector(makeQuery), with: nil, afterDelay: 0.75)
    }

    @objc private func makeQuery() {
        guard let text = search.searchBar.text else { return }
        presenter?.searchWithQuery(query: text.lowercased())
    }
}
