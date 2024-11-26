//
//  Constant.swift
//  chatku
//
//  Created by Anang Kurniawan on 26/11/24.
//

struct Constant {
    static let title = "Chat Ku"
    static let chatCell = "ChatCell"
    
    struct Error {
        static let errorSignout = "Error signing out: %@"
    }
    
    struct Navigation {
        static let loginToChat = "loginToChat"
        static let registerToChat = "registerToChat"
    }
    
    struct Firestore {
        static let collectionName = "messages"
        static let body = "body"
        static let sender = "sender"
    }
}
