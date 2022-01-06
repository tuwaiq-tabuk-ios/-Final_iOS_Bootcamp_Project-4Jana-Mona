//
//  Constants.swift
//  Jana
//
//  Created by mona M on 1/1/2022.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    
    enum sections: Int {
        case kitchen
        case bedrooms
        case bathrooms
        case garden
        case restaurant
        case hospital
        case school
        
        var title: String {
            switch self {
            case .kitchen:
                return "kitchen"
            case .bedrooms:
                return "bedrooms"
            case .bathrooms:
                return "bathrooms"
            case .garden:
                return "garden"
            case .restaurant:
                return "restaurant"
            case .hospital:
                return "hospital"
            case .school:
                return "school"
            }
        }
        
        var image: String {
            switch self {
            case .kitchen:
                return "icKitchen"
            case .bedrooms:
                return "bgBathrooms"
            case .garden:
                return "bgGarden"
            case .restaurant:
                return "bgRestaurant"
            case .hospital:
                return "bgHospital"
            case .school:
                return "bgSchool"
            case .bathrooms:
                return "bgBedrooms"
            }
        }

    }
    
    enum Menu {
        
        case children
        case logout
        
        var title: String {
            switch self {
            case .children:
                return "Children"
            case .logout:
                return "Logout"
            }
        }
        
        var viewControllerName: String {
            switch self {
            case .children:
                return "ChildrenViewController"
            case .logout:
                return ""
            }
        }
        
    }
    
}
