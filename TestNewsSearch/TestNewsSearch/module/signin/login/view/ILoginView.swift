//
//  ILoginView.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 24.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit

protocol ILoginView: class, IView {
    func showError(error: Error)
}

