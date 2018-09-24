//
//  SignupViewController.swift
//  Firestore-Sampler
//
//  Created by ShinokiRyosei on 2017/10/14.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit

import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    static func instantiate() -> UINavigationController {

        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! UINavigationController
        return controller
    }

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

    @IBAction func didSelectedLogin(_ sender: UIButton) {

        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }

    func showErrorAlert(of message: String) {

        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func signup(withEmail email: String, password: String) {

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in

            if error != nil {

                self?.showErrorAlert(of: "サインアップに失敗しました。再度試してください。")
                return
            }

            result?.user.sendEmailVerification(completion: { error in

                if error != nil {

                    self?.showErrorAlert(of: "サインアップに失敗しました。")
                    return
                }

                let alert = UIAlertController(title: "サインアップしました", message: "登録に際してメールアドレスの認証を行ってください", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in

                    self?.dismiss(animated: true, completion: nil)
                }))

                self?.present(alert, animated: true, completion: nil)
            })
        }
    }
}
