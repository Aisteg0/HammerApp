//
//  Menu.swift
//  HammerApp
//
//  Created by Михаил Ганин on 23.07.2025.
//

import SwiftUI

protocol MenuViewProtocol {
    func displayCategories(_ categories: [CategoriesList])
    func showError(_ message: String)
    func scrollToCategory(_ category: String)
}

struct MenuView: View, MenuViewProtocol {
    @State private var currentDate = Date()
    @State private var categories: [CategoriesList] = []
    @State private var selectedCategory: String = "Beef"
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var imageCache: [String: UIImage] = [:]
    @State private var scrollOffset: CGFloat = 0
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    
    private let headerHeight: CGFloat = 50
    private let bannerHeight: CGFloat = 80
    private let menuHeight: CGFloat = 50
    private var topSectionHeight: CGFloat { headerHeight + bannerHeight + menuHeight }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear
                                .frame(height: 200)
                            
                            menuItemsSections
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetKey.self,
                                        value: geo.frame(in: .named("scroll")).minY
                                    )
                            }
                        )
                    }
                    .coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollOffsetKey.self) { value in
                        scrollOffset = value
                    }
                    .onAppear {
                        scrollViewProxy = proxy
                    }
                }
                
                VStack(spacing: 0) {
                    if scrollOffset > -headerHeight {
                        HeaderView(headerHeight: headerHeight)
                    }
                    
                    if scrollOffset > -(headerHeight + bannerHeight) {
                        PromotionBanner()
                    }
                    
                    categoriesMenu
                }
                .background(Color(.systemBackground))
            }
            .navigationBarHidden(true)
            .onAppear {
                startTimer()
                loadCategories()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var categoriesMenu: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.idCategory) { category in
                    Button(action: {
                        selectedCategory = category.strCategory ?? ""
                        withAnimation {
                            scrollViewProxy?.scrollTo(category.strCategory ?? "", anchor: .top)
                        }
                    }) {
                        Text(category.strCategory ?? "")
                            .frame(width: 88)
                            .foregroundColor(selectedCategory == category.strCategory ? .white : .black)
                            .padding(.vertical, 8)
                            .background(selectedCategory == category.strCategory ? Color.blue : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .frame(height: menuHeight)
        .background(Color(.systemBackground))
    }
    
    private var menuItemsSections: some View {
        ForEach(categories, id: \.idCategory) { category in
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageUrl = category.strCategoryThumb,
                       let image = imageCache[imageUrl] {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(12)
                    }
                    
                    Text(category.strCategoryDescription ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
                .onAppear {
                    loadImageIfNeeded(for: category)
                }
            } header: {
                Text(category.strCategory ?? "")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .id(category.strCategory ?? "")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            currentDate = Date()
        }
    }
    
    private func loadCategories() {
        isLoading = true
        errorMessage = nil
        
        let service = NetworkService()
        service.getMenuCategories { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    errorMessage = "Нет данных"
                    return
                }
                
                do {
                    let responseModel = try JSONDecoder().decode(CategoriesModel.self, from: data)
                    categories = responseModel.categories ?? []
                    if let firstCategory = categories.first?.strCategory {
                        selectedCategory = firstCategory
                    }
                } catch {
                    errorMessage = "Ошибка декодирования: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func loadImageIfNeeded(for category: CategoriesList) {
        guard let imageUrlString = category.strCategoryThumb,
              let url = URL(string: imageUrlString),
              imageCache[imageUrlString] == nil else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageCache[imageUrlString] = image
                }
            }
        }.resume()
    }
    
    func displayCategories(_ categories: [CategoriesList]) {
        self.categories = categories
        if let firstCategory = categories.first?.strCategory {
            selectedCategory = firstCategory
        }
    }
    
    func showError(_ message: String) {
        errorMessage = message
    }
    
    func scrollToCategory(_ category: String) {
        withAnimation {
            scrollViewProxy?.scrollTo(category, anchor: .top)
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
    MenuView()
}
