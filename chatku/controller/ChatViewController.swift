//
//  ChatViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 25/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    private var messages: [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        title = Constant.title
        navigationItem.hidesBackButton = true
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = UITableView.automaticDimension
        
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
            try await db.collection(Constant.Firestore.collectionName).addDocument(
                data: [
                    Constant.Firestore.body: message,
                    Constant.Firestore.sender: user,
                    Constant.Firestore.date: Date().timeIntervalSince1970,
                ]
            )
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
        if let user = Auth.auth().currentUser?.email {
            cell.updateContent(message: messages[indexPath.row], currentUser: user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func loadMessages() {
        db.collection(Constant.Firestore.collectionName).order(by: Constant.Firestore.date).addSnapshotListener { documentSnapshot, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let documents = documentSnapshot?.documents {
                    self.messages = []
                    for document in documents {
                        let data = document.data()
                        if let message = data[Constant.Firestore.body] as? String, let sender = data[Constant.Firestore.sender] as? String {
                            let message = Message(message: message, user: sender)
                            self.messages.append(message)
                            self.chatTableView.reloadData()
                        }
                    }
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            }
        }
    }
}
