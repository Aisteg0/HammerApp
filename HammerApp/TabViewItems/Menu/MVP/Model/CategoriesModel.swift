//
//  MenuModel1.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import Foundation

struct CategoriesModel : Codable {
    let categories : [CategoriesList]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([CategoriesList].self, forKey: .categories)
    }
}
