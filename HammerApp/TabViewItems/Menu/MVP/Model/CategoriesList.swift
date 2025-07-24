//
//  MenuModel.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import Foundation

struct CategoriesList : Codable {
    let idCategory : String?
    let strCategory : String?
    let strCategoryThumb : String?
    let strCategoryDescription : String?

    enum CodingKeys: String, CodingKey {

        case idCategory = "idCategory"
        case strCategory = "strCategory"
        case strCategoryThumb = "strCategoryThumb"
        case strCategoryDescription = "strCategoryDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idCategory = try values.decodeIfPresent(String.self, forKey: .idCategory)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        strCategoryThumb = try values.decodeIfPresent(String.self, forKey: .strCategoryThumb)
        strCategoryDescription = try values.decodeIfPresent(String.self, forKey: .strCategoryDescription)
    }

}
