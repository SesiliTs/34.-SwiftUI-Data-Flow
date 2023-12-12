//
//  ShopViewModel.swift
//  34 SwiftUI Data Flow
//
//  Created by Sesili Tsikaridze on 12.12.23.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    
    @Published var showAlert = false
    
    @Published var cartProducts = [
        Product(name: "Pasta", price: 4.99, stock: 15, image: Image("Pasta"), chosenQuantity: 0),
        Product(name: "Pesto Sauce", price: 7.50, stock: 7, image: Image("Pesto"), chosenQuantity: 0),
        Product(name: "Garlic", price: 2.50, stock: 10, image: Image("Garlic"), chosenQuantity: 0),
        Product(name: "Bread", price: 1.80, stock: 13, image: Image("Bread"), chosenQuantity: 0),
        Product(name: "Peanut Butter", price: 12.30, stock: 10, image: Image("Peanut"), chosenQuantity: 0),
        Product(name: "Carrots", price: 2.90, stock: 21, image: Image("Carrot"), chosenQuantity: 0),
        Product(name: "Parmesan", price: 25.50, stock: 7, image: Image("Parm"), chosenQuantity: 0)
    ]
    
    var totalCartQuantity: Int {
        return cartProducts.reduce(0) { $0 + $1.chosenQuantity }
    }
    var totalCartPrice: Double {
        return cartProducts.reduce(0.0) { $0 + Double($1.chosenQuantity) * $1.price }
    }
    
    func addToCart(productID: UUID) {
        if let index = cartProducts.firstIndex(where: { $0.id == productID }) {
            if cartProducts[index].stock > 0 {
                var updatedProduct = cartProducts[index]
                updatedProduct.chosenQuantity += 1
                updatedProduct.stock -= 1
                cartProducts[index] = updatedProduct
            } else {
                showAlert = true
            }
        }
    }
    
    func removeFromCart(productID: UUID) {
        if let index = cartProducts.firstIndex(where: { $0.id == productID }) {
            var updatedProduct = cartProducts[index]
            if updatedProduct.chosenQuantity > 0 {
                updatedProduct.chosenQuantity -= 1
                updatedProduct.stock += 1
                cartProducts[index] = updatedProduct
            }
        }
    }
    
    func removeProductFromCart(productID: UUID) {
        if let index = cartProducts.firstIndex(where: { $0.id == productID }) {
            var updatedProduct = cartProducts[index]
            if updatedProduct.chosenQuantity > 0 {
                updatedProduct.stock += updatedProduct.chosenQuantity
                updatedProduct.chosenQuantity = 0
                cartProducts[index] = updatedProduct
            }
        }
    }
    
}
