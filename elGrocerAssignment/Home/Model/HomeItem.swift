//
//  HomeItem.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

struct HomeItem: Hashable {
    let id = UUID()
    let title: String
    let image: String
    
    static func getBanners() -> [HomeItem] {
        return [
            HomeItem(title: "Mega Sale", image: "banner1"),
            HomeItem(title: "New Arrivals", image: "banner2"),
            HomeItem(title: "50% Off", image: "banner3")
        ]
    }
    
    static func getCategories() -> [HomeItem] {
        return [
            HomeItem(title: "Elect", image: "bolt.fill"),
            HomeItem(title: "Fashion", image: "tshirt.fill"),
            HomeItem(title: "Home", image: "house.fill"),
            HomeItem(title: "Beauty", image: "heart.fill"),
            HomeItem(title: "Toys", image: "puzzlepiece.fill"),
            HomeItem(title: "Sports", image: "sportscourt.fill"),
            HomeItem(title: "Books", image: "book.fill"),
            HomeItem(title: "Cart", image: "cart.fill"),
            HomeItem(title: "Elect", image: "bolt.fill"),
            HomeItem(title: "Fashion", image: "tshirt.fill"),
            HomeItem(title: "Home", image: "house.fill"),
            HomeItem(title: "Beauty", image: "heart.fill"),
            HomeItem(title: "Toys", image: "puzzlepiece.fill"),
            HomeItem(title: "Sports", image: "sportscourt.fill"),
            HomeItem(title: "Books", image: "book.fill"),
            HomeItem(title: "Cart", image: "cart.fill")
        ]
    }
    
    static func getProducts() -> [HomeItem] {
        return (1...20).map { HomeItem(title: "Product \($0)", image: "cube.box.fill") }
    }
    
    // You could add a method simulating async fetch as well
    static func fetchAllData(completion: @escaping (_ banners: [HomeItem], _ categories: [HomeItem], _ products: [HomeItem]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(getBanners(), getCategories(), getProducts())
        }
    }
}
