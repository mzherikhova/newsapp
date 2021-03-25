//
//  NewsSource.swift
//  TestNewsSearch
//
//  Created by 1 on 19.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import UIKit

class NewsSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    weak var owner: TableOwner?
    weak var scrollListener: ScrollingListener?

   private var isHorizontal: Bool = false
    private var items: [NewsItem] = [NewsItem]()
    private var columns = 1

    func updateItems(items: [NewsItem]) {
        self.items = [NewsItem]()
        self.items.append(contentsOf: items)
        self.owner?.reloadData()
    }

    func setupHorizontal(isHorizontal: Bool) {
        self.isHorizontal = isHorizontal
        columns = isHorizontal ? 2: 1

        self.owner?.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  items.count / columns
     }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsListCell.cellId, for: indexPath) as? NewsListCell else {
            return UICollectionViewCell()
        }

        let item = items[indexPath.section*columns + indexPath.row]
        cell.setupWithData(item: item)
       if  (cell.favoriteButton.target(forAction: #selector(favoriteClicked(sender:)), withSender: self) == nil) {
            cell.favoriteButton.tag = indexPath.section*columns + indexPath.row
            cell.favoriteButton.addTarget(self, action: #selector(favoriteClicked(sender:)), for: .touchUpInside )

        }

        return cell

    }

    @objc func favoriteClicked(sender: Any) {
        if let index = (sender as? UIButton)?.tag {
            owner?.actionSelectedInRow(index: index)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / (isHorizontal ? 2 : 1) - 20
        let height: CGFloat = 130.0

        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if (indexPath.section == numberOfSections(in: collectionView)-1) {
        scrollListener?.scrolledBottom()
        }
    }

   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooter.cellId, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        guard let _ = scrollListener else {
            return CGSize.zero
        }

        let width = collectionView.frame.width / (isHorizontal ? 2 : 1)

        if (section == numberOfSections(in: collectionView)-1) {
            return CGSize(width: width, height: 40)
        } else {
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = (indexPath.section*columns + indexPath.row)
        owner?.selectedItem(index: index)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
