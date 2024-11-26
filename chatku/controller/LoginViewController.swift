//
//  LoginViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e = error {
                    strongSelf.errorLabel.text = e.localizedDescription
                } else {
                    strongSelf.performSegue(withIdentifier: Constant.Navigation.loginToChat, sender: self)
                }
            }
        }
    }
    
}
