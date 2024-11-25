//
//  ChatViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController : UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    private var messages: [String] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        title = Constant.title
        navigationItem.hidesBackButton = true
        chatTableView.dataSource = self
        chatTableView.register(
            UINib(nibName: Constant.chatCell, bundle: nil),
            forCellReuseIdentifier: Constant.chatCell
        )
        
        loadMessages()
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        if let user = Auth.auth().currentUser?.email, let message = chatTextField.text {
            Task {
                await sendMessage(message: message, user: user)
            }
        }
    }
    
    private func sendMessage(message: String, user: String) async {
        do {
            let ref = try await db.collection(Constant.Firestore.collectionName).addDocument(
                data: [
                    Constant.Firestore.body: message,
                    Constant.Firestore.sender: user,
                ]
            )
            print("Document added with ID: \(ref.documentID)")
            DispatchQueue.main.async {
                self.chatTextField.text = ""
            }
        } catch {
            print("Error adding document: \(error.localizedDescription)")
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.chatCell, for: indexPath) as! ChatCell
        cell.messageLabel.text = messages[indexPath.row]
        return cell
    }
    
    private func loadMessages() {
        Task {
            do {
                let snapshot = try await db.collection(Constant.Firestore.collectionName).getDocuments()
                for document in snapshot.documents {
                    let data = document.data()
                    if let sender = data[Constant.Firestore.sender] as? String, let message = data[Constant.Firestore.body] as? String {
                        self.messages.append(message)
                        self.chatTableView.reloadData()
                    }
                }
            } catch {
                print("Error getting documents: \(error.localizedDescription)")
            }
        }
    }
}
