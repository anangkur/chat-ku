//
//  RegisterViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func onRegisterClicked(_ sender: UIButton) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                } else {
                    self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
            }
        }
    }
}
