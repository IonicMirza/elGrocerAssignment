//
//  HomeViewModel.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//
 import UIKit

class HomeViewModel {
    var banners: [HomeItem] = []
    var categories: [HomeItem] = []
    var products: [HomeItem] = []
    
    /// Fetches data for banners, categories, and products from a data source
    func fetchData(completion: @escaping () -> Void) {
        HomeItem.fetchAllData { banners, categories, products in
            self.banners = banners
            self.categories = categories
            self.products = products
            completion()
        }
    }
}
