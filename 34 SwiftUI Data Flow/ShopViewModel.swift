//
//  ShopViewModel.swift
//  34 SwiftUI Data Flow
//
//  Created by Sesili Tsikaridze on 12.12.23.
//

import Foundation

class ShopViewModel: ObservableObject {
    
    @Published var cartProducts = [Product]()
    
    func addToCart(product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.id == product.id }) {
            cartProducts[index].chosenQuantity += 1
        } else {
            let updatedProduct = product
            updatedProduct.chosenQuantity = 1
            cartProducts.append(updatedProduct)
        }
    }
    
    func removeFromCart(product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.id == product.id }) {
            if cartProducts[index].chosenQuantity > 0 {
                cartProducts[index].chosenQuantity -= 1
            }
        }
    }
    
}
