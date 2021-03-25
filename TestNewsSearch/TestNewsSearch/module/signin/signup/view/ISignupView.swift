//
//  ISignupView.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 25.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit

protocol ISignupView: class, IView {
    func showError(error: Error)
    func showDialog(message: String, _ title: String?, _ action: (() -> Void)?)
}
