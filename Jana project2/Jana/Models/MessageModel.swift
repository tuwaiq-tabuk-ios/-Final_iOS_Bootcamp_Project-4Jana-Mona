

//
//  SceneDelegate.swift
//  Jana
//
//  Created by mona M on 26/05/1443 AH.
//
import Foundation
import UIKit
import ActionSheetPicker_3_0
import CoreMedia
import CodableFirebase
import AVFoundation

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
