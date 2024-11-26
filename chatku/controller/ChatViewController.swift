//
//  ChatViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import UIKit
import FirebaseAuth

class ChatViewController : UIViewController {
    
    override func viewDidLoad() {
        title = Constant.title
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(Constant.Error.errorSignout, signOutError.localizedDescription)
        }
    }
}
