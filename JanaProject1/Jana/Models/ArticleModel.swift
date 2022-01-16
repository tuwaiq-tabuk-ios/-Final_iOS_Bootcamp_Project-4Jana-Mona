//
//  ArticleModel.swift
//  Jana
//
//  Created by mona M on 21/12/2021.
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
