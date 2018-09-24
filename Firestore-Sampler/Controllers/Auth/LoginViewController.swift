//
//  LoginViewController.swift
//  Firestore-Sampler
//
//  Created by ShinokiRyosei on 2017/10/14.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

import Firebase

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

        Auth.auth().signIn(withEmail: email, password: password) { [ weak self] result, error in

            if error != nil {

                self?.showErrorAlert(of: "ログインに失敗しました。再度お試しください")
                return
            }
            guard let dataResult = result else {

                self?.showErrorAlert(of: "ログイン失敗しました。再度お試しください")
                return
            }

            if dataResult.user.isEmailVerified {

                self?.dismiss(animated: true, completion: nil)
            }
            else {

                self?.showErrorAlert(of: "メールアドレスを認証してください")
            }
        }
    }

    func showErrorAlert(of message: String) {

        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
