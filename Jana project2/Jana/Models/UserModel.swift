//
//  SceneDelegate.swift
//  Jana
//
//  Created by mona M on 23/05/1443 AH.
//
import Foundation

// MARK: - UserModel
struct UserModel: Codable {
  let udid, userName, email: String
  
  enum CodingKeys: String, CodingKey {
    case udid
    case userName = "user-name"
    case email
  }
}
