//
//  HomeView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack {
                        Image(AppImage.Image.carrot)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 48)
                        
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                
                                Text("Hoàng Mai, Hà Nội")
                                .font(.merriWeather(.regular, fontSize: 18))
                        }
                        .foregroundColor(.white)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.primaryApp)
                                .padding(.leading,4)
                            TextField("Tìm kiếm", text: $homeVM.txtSearch)
                        }
                        .frame(height: 46)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(Color.primaryApp)
                    
                    VStack {
                        Image(AppImage.Image.banner)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 115)
                        
                        CustomSection(title: "Khuyến mãi đặc biệt", titleButton: "Xem tất cả")
                        
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (homeVM.offerArr, id: \.id) { pObj in
                                    ProductCell(pObj: pObj, didAddCart: {
                                        CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                            self.homeVM.errorMessage = msg
                                            self.homeVM.showError = true
                                        }
                                    })
                                }
                            }
                        }
                        
                        CustomSection(title: "Bán chạy nhất", titleButton: "Xem tất cả")
                        
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (homeVM.bestArr, id: \.id) { pObj in
                                    ProductCell(pObj: pObj, didAddCart: {
                                        CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                            self.homeVM.errorMessage = msg
                                            self.homeVM.showError = true
                                        }
                                    })
                                }
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (homeVM.listArr, id: \.id) { pObj in
                                    ProductCell(pObj: pObj, didAddCart: {
                                        CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                            self.homeVM.errorMessage = msg
                                            self.homeVM.showError = true
                                        }
                                    })
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .alert(isPresented: $homeVM.showError, content: {
                Alert(title: Text(Globs.AppName), message: Text(homeVM.errorMessage), dismissButton: .default(Text("OK")) )
            })
            .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
