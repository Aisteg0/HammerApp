//
//  Presentor.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import Foundation

protocol MenuPresenterProtocol {
    func viewDidLoad()
    func didSelectCategory(_ category: String)
}

class MenuPresenter: MenuPresenterProtocol {
    var view: MenuViewProtocol?
    private let networkService: NetworkingServiceProtocol
    
    init(networkService: NetworkingServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        loadCategories()
    }
    
    func didSelectCategory(_ category: String) {
        view?.scrollToCategory(category)
    }
    
    private func loadCategories() {
        networkService.getMenuCategories { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.view?.showError(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    self?.view?.showError("Нет данных")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(CategoriesModel.self, from: data)
                    self?.view?.displayCategories(response.categories ?? [])
                } catch {
                    self?.view?.showError("Ошибка декодирования")
                }
            }
        }
    }
}
