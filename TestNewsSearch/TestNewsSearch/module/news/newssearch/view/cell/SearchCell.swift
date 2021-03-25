//
//  SearchCell.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {

    static let cellId: String = "SearchCell"

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(item: SearchItem) {
        titleLabel.text = item.title
    }
}
