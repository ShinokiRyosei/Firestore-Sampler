//
//  LoginViewController.swift
//  Firestore-Sampler
//
//  Created by ShinokiRyosei on 2017/10/14.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func didSelectedLogin(_ sender: UIButton) {

        guard let email = emailTextField.text, let password = passwordTextField.text else {

            return
        }

        if !email.isEmpty && !password.isEmpty {

            self.login(withEmail: email, password: password)
        }
        else {

            self.showErrorAlert(of: "メールアドレスとパスワードを入力してください")
        }
    }

    func login(withEmail email: String, password: String) {

    }

    func showErrorAlert(of message: String) {

        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
