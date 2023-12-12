//
//  ContentView.swift
//  34 SwiftUI Data Flow
//
//  Created by Sesili Tsikaridze on 11.12.23.
//

import SwiftUI

class Product: ObservableObject, Identifiable {
    var id = UUID()
    let name: String
    let price: Double
    let stock: Int
    let image: Image
    var chosenQuantity: Int
    
    init(id: UUID = UUID(), name: String, price: Double, stock: Int, image: Image, chosenQuantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.stock = stock
        self.image = image
        self.chosenQuantity = chosenQuantity
    }
    
}

struct ShopView: View {
    
    @StateObject private var viewModel = ShopViewModel()
    
    private let products = [
        Product(name: "Pasta", price: 4.99, stock: 15, image: Image("Pasta"), chosenQuantity: 0),
        Product(name: "Pesto Sauce", price: 7.50, stock: 7, image: Image("Pesto"), chosenQuantity: 0),
        Product(name: "Garlic", price: 2.50, stock: 10, image: Image("Garlic"), chosenQuantity: 0),
        Product(name: "Sourdough Bread", price: 1.80, stock: 13, image: Image("Bread"), chosenQuantity: 0),
        Product(name: "Peanut Butter", price: 12.30, stock: 10, image: Image("Peanut"), chosenQuantity: 0),
        Product(name: "Carrots", price: 2.90, stock: 21, image: Image("Carrot"), chosenQuantity: 0),
        Product(name: "Parmesan Cheese", price: 25.50, stock: 7, image: Image("Parm"), chosenQuantity: 0)
    ]
    
    var body: some View {
        
        ZStack {
            Color.init(hex: "#fbf4f4")
                .ignoresSafeArea()
            
            VStack() {
                Text("MARKET")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.init(hex: "#d95453"))
                    .padding(.vertical, 30)
                
                ScrollView {
                    ForEach(products) { product in
                        HStack {
                            product.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 80)
                                .clipped()
                                .padding(.all, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(product.name)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(Color.init(hex: "#d95453"))
                                
                                Text(String(format: "$ %.2f", product.price))
                                    .font(.system(size: 16, weight: .medium))
                                Spacer()
                                
                                Text("stock: \(product.stock)")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.gray)
                                
                            }
                            .padding(.vertical, 20)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    viewModel.removeFromCart(product: product)
                                    
                                }) {
                                    Image(systemName: "minus")
                                        .foregroundStyle(Color.init(hex: "#d95453"))
                                }
                                .buttonStyle(.plain)
                                .contentShape(Rectangle())
                                
                                Text("\(product.chosenQuantity)")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(Color.black)
                                
                                Button(action: {
                                    viewModel.addToCart(product: product)
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(Color.init(hex: "#d95453"))
                                }                                .buttonStyle(.plain)
                                    .contentShape(Rectangle())
                                
                                
                                
                                
                            }
                            .padding(.trailing, 15)
                        }
                        .background(.white)
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                FooterView()
            }
            .padding(.horizontal, 20)
            
        }
    }
}

struct FooterView: View {
    var body: some View {
        HStack() {
            Image(systemName: "cart")
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
            Text(":  7")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
            Text("290 $")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color.init(hex: "#d95453"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ShopView()
}
