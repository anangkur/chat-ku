//
//  Message.swift
//  chatku
//
//  Created by Anang Kurniawan on 07/12/24.
//

struct Message {
    let message: String
    let user: String
    init(message: String, user: String) {
        self.message = message
        self.user = user
    }
}
