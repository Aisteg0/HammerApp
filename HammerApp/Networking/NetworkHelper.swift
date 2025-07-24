//
//  NetworkHelper.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import Foundation

protocol NetworkHelpersProtocol {
  func getDefaultRequest(_ with: String, method: HTTPMethods, queryItems: [URLQueryItem]?) -> URLRequest?
}

public class NetworkHelpers: NetworkHelpersProtocol {
  func getDefaultRequest(_ with: String, method: HTTPMethods, queryItems: [URLQueryItem]?) -> URLRequest? {
    var recentlyRequest: URLRequest? {
      var components = URLComponents(string: with)
      if let queryItems {
        components?.queryItems = queryItems
      }
      guard let url = components?.url else { return nil }
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      return request
    }
    return recentlyRequest
  }
}
