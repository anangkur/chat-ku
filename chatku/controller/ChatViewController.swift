//
//  ChatViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import UIKit
import FirebaseAuth

class ChatViewController : UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    private var messages: [String] = []
    
    override func viewDidLoad() {
        createDummyData()
        
        title = Constant.title
        navigationItem.hidesBackButton = true
        chatTableView.dataSource = self
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.chatCell, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    private func createDummyData() {
        for i in 1...100 {
            messages.append("item \(i)")
        }
    }
}
