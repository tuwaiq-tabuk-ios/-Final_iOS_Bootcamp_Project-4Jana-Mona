//
//  ChildModel.swift
//  Jana
//
//  Created by mona M on 01/06/1443 AH.
//

import Foundation

// MARK: - ChildModel
struct Child: Codable {
    let uid, iamge, name, dateOfBirth: String
    let relationship, createdDate: String

    enum CodingKeys: String, CodingKey {
        case uid, iamge, name
        case dateOfBirth = "date-of-birth"
        case relationship
        case createdDate = "created-date"
    }
}
