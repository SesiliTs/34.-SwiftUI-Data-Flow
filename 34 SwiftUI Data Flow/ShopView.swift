//
//  ContentView.swift
//  34 SwiftUI Data Flow
//
//  Created by Sesili Tsikaridze on 11.12.23.
//

import SwiftUI

struct Product: Identifiable {
    var id = UUID()
    let name: String
    let price: Double
    var stock: Int
    var image: Image
    var chosenQuantity: Int
}

struct ShopView: View {
    
    @StateObject private var viewModel = ShopViewModel()
    
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
                    ForEach(viewModel.cartProducts.indices, id: \.self) { index in
                        let product = viewModel.cartProducts[index]
                        
                        HStack {
                            product.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
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
                            
                            VStack(alignment: .trailing, spacing: 10) {
                                HStack() {
                                    Button(action: {
                                        viewModel.removeFromCart(productID: product.id)
                                    }) {
                                        Image(systemName: "minus")
                                            .foregroundStyle(Color.init(hex: "#d95453"))
                                    }
                                    .buttonStyle(BorderedButtonStyle())
                                    .tint(.white)
                                    
                                    Text("\(product.chosenQuantity)")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(Color.black)
                                    
                                    Button(action: {
                                        viewModel.addToCart(productID: product.id)
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color.init(hex: "#d95453"))
                                    }
                                    .alert(isPresented: $viewModel.showAlert) {
                                        Alert(title: Text("out of Stock"), message: Text("Product is out of stock"), dismissButton: .default(Text("OK")))
                                    }
                                    .buttonStyle(BorderedButtonStyle())
                                    .tint(.white)
                                }
                                
                                Button(action: {
                                    viewModel.removeProductFromCart(productID: product.id)
                                    
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundStyle(Color.init(hex: "#d95453"))
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .tint(.white)
                            }
                        }
                        .background(.white)
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                FooterView(cartQuantity: viewModel.totalCartQuantity, totalPrice: viewModel.totalCartPrice)
            }
            .padding(.horizontal, 20)
            
        }
    }
}

struct FooterView: View {
    let cartQuantity: Int
    let totalPrice: Double
    
    var body: some View {
        HStack() {
            Image(systemName: "cart")
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
            Text(":  \(cartQuantity)")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
            Text(String(format: "%.2f $", totalPrice))
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
