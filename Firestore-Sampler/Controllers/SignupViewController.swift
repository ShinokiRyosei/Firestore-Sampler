//
//  SignupViewController.swift
//  Firestore-Sampler
//
//  Created by ShinokiRyosei on 2017/10/14.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!

    @IBOutlet var passwordConfirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func didSelectedSignup(_ sender: UIButton) {

        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirm = passwordConfirmTextField.text else {

            return
        }

        if !email.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty {

            if password == passwordConfirm {

                self.signup(withEmail: email, password: password)
            }
            else {

                self.showErrorAlert(of: "パスワードが一致しません")
            }
        }
        else {

            self.showErrorAlert(of: "メールアドレス・パスワードを入力してください")
        }
    }

    func showErrorAlert(of message: String) {

        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func signup(withEmail email: String, password: String) {

    }
}
