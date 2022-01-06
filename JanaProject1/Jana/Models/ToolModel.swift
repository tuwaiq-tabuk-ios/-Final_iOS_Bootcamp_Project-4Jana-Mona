//
//  ToolModel.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import Foundation

// MARK: - ToolModel
struct ToolModel: Codable {
    let uid, iamge, title: String?
    let type: Int?
    let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case uid, iamge, title, type
        case createdDate = "created-date"
    }
}
