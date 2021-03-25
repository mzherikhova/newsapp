//
//  NewsItemController.swift
//  TestNewsSearch
//
//  Created by 1 on 20.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsItemController: BaseViewController, INewsView {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    var favoriteButton: UIBarButtonItem?

var newsPresenter: INewsItemPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        self.newsPresenter?.setupContent()

    }
    private func setupMenu() {
        favoriteButton = UIBarButtonItem(image: UIImage(named: "unfavorite"), style: .plain, target: self, action: #selector(changeFavorite))
        self.navigationItem.rightBarButtonItem = favoriteButton
    }

    func setupItem(newsItem: NewsItem) {
        self.titleLabel.text = newsItem.title
        self.newsText.text = newsItem.content ?? newsItem.description
    self.newsDateLabel.text = newsItem.publishedAt?.formatToString("dd.MM.yyyy")
        self.updateFavorite(isFavorite: newsItem.favorite)
        guard let imageUrl = newsItem.urlToImage else {
            return
        }
        ImageManager.sharedInstance.setImage(toImageView: self.newsImage, forKey: imageUrl)
    }

    @objc private func changeFavorite() {
        newsPresenter?.updateFavorite()
    }

    func updateFavorite(isFavorite: Bool) {
        favoriteButton?.image = UIImage(named: isFavorite ? "favorite" : "unfavorite")
    }
}

extension NewsItemController: IInputView {
    func input(data: Any?) {
        self.newsPresenter?.newsItem = data as? NewsItem
    }
}
