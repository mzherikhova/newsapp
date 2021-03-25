//
//  LoginViewController.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 23.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit


class LoginViewController:  BaseViewController, ILoginView {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var presenter: ILoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // TODO: Validate Text Fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        presenter?.authFirebase(email: email, password: password)
    }
    
    func showError(error: Error) {
        self.errorLabel.text = error.localizedDescription
        self.errorLabel.alpha = 1
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        presenter?.openSignUp()
    }
}
