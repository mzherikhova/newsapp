//
//  Map+Date.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import ObjectMapper

extension Map {
    func toDate (key: String, _ format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        var dateString: String? = nil
        dateString <- self[key]

        guard let date = dateString else {
            return Date()
        }

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_GB")

            dateFormatter.dateFormat = format

            return dateFormatter.date(from: date)
    }
}
