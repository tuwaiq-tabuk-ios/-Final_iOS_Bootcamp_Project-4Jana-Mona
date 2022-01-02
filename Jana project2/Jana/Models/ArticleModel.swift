
//
//  SceneDelegate.swift
//  Jana
//
//  Created by mona M on 24/05/1443 AH.
//

import Foundation

// MARK: - ArticleModel
struct ArticleModel: Codable {
  let udid, title, details, createdDate: String
  
  enum CodingKeys: String, CodingKey {
    case udid, title, details
    case createdDate = "created-date"
  }
}
