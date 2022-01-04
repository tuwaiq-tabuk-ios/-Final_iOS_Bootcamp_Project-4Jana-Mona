//
//
//  MessageModel.swift
//  Jana
//
//  Created by mona M on 1/1/2022.
//

import Foundation

struct MessageModel: Codable {
    let uid, uidUser, message: String
    let isRead: Bool
    let uidSender, createdDate: String

    enum CodingKeys: String, CodingKey {
        case uid
        case uidUser = "uid-user"
        case message
        case isRead = "is-read"
        case uidSender = "uid-sender"
        case createdDate = "created-date"
    }
}
