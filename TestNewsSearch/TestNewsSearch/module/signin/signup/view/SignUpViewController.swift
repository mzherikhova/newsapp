//
//  SignUpViewController.swift
//  TestNewsSearch
//
//  Created by Margarita Zherikhova on 25.03.2021.
//  Copyright © 2021 azharkova. All rights reserved.
//

import UIKit

class SignUpViewController:  BaseViewController, ISignupView {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var presenter: ISignUpPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func SignUpAction(_ sender: Any) {
        // TODO: Validate Text Fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        presenter?.signUpFirebase(email: email, password: password)
    }
    
    func showError(error: Error) {
        self.errorLabel.text = error.localizedDescription
        self.errorLabel.alpha = 1
    }
}

