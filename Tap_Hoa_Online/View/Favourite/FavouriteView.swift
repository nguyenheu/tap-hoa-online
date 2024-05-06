//
//  FavouriteView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

struct FavouriteView: View {
    
    @StateObject var favVM = FavouriteViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack {
                    ForEach( favVM.listArr , id: \.id, content: { fObj in
                        FavouriteRow(fObj: fObj)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                HStack{
                    Spacer()
                    
                    Text("Sản phẩm ưa dùng")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
                
                RoundButton(title: "Thêm tất cả vào giỏ")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .onAppear{
            favVM.serviceCallList()
        }
        .ignoresSafeArea()
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
