//
//  SearchSource.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import UIKit

class SearchSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    weak var owner: TableOwner?

    private var isHorizontal: Bool = false
    private var items: [SearchItem] = [SearchItem]()
    private var columns = 1

    func updateItems(items: [SearchItem]) {
        self.items = [SearchItem]()
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
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.cellId, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }

        let item = items[indexPath.section*columns + indexPath.row]
        cell.setupCell(item: item)

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / (isHorizontal ? 2 : 1) - 20
        let height: CGFloat = 40.0

        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = (indexPath.section*columns + indexPath.row)
        owner?.selectedItem(index: index)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
