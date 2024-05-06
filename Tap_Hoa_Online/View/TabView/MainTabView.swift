//
//  MainTabView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Trang chủ", systemImage: "house.fill")
                }
                .tag(0)

            ExploreView()
                .tabItem {
                    Label("Tìm kiếm", systemImage: "magnifyingglass")
                }
                .tag(1)

            CartView()
                .tabItem {
                    Label("Giỏ hàng", systemImage: "cart")
                }
                .tag(2)

            FavouriteView()
                .tabItem {
                    Label("Ưa thích", systemImage: "heart")
                }
                .tag(3)

            AccountView()
                .tabItem {
                    Label("Tài khoản", systemImage: "person")
                }
                .tag(4)
        }
        .accentColor(Color.primaryApp)
        .padding(.vertical)
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
