//
//  NetworkService.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import Foundation

protocol NetworkingServiceProtocol {
    func getMenuCategories(completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkService: NetworkingServiceProtocol {
    private let networkingHelper: NetworkHelpersProtocol
    
    init(networkingHelper: NetworkHelpersProtocol = NetworkHelpers()) {
        self.networkingHelper = networkingHelper
    }
    
    func getMenuCategories(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let stringURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        let request = networkingHelper.getDefaultRequest(stringURL, method: .get, queryItems: nil)
        guard let request else { return }
        
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
