//
//  BaseViewController.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func showDialog(message: String, _ title: String? = nil, _ action: (() -> Void)? = nil ) {
        let dialog = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { _ in
            action?()
        }))
        self.present(dialog, animated: true, completion: nil)
    }

    func showError(error: ErrorResponse) {
        if (error.errorType == .network) {
            self.showDialog(message: "Проверьте соединение с интернетом и попробуйте еще раз")
        } else {
            self.showDialog(message: error.message ?? "Не удалось загрузить данные")
        }
    }
}
