//
//  AccountView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack{
            VStack{
                
                HStack(spacing: 15) {
                    Image("user")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack{
                        
                        HStack{
                            Text("Mathew")
                                .font(.merriWeather(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.primaryApp)
                            
                            Spacer()
                        }
                        
                        Text("mathew1@gmail.com")
                            .font(.merriWeather(.regular, fontSize: 16))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                            .accentColor(.secondaryText)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Divider()
                
                ScrollView {
                    LazyVStack {
                        NavigationLink {
                            MyOrdersView()
                        } label: {
                            AccountRow(title: "Đơn hàng", icon: "icon_bg")
                        }
                        
                        
                        NavigationLink {
                            MyDetailsView()
                        } label: {
                            AccountRow(title: "Thông tin chi tiết", icon: "icon_bg")
                        }

                        NavigationLink {
                            DeliveryAddressView()
                        } label: {
                            AccountRow(title: "Địa chỉ giao hàng", icon: "icon_bg")
                        }
                        
                        NavigationLink {
                            PaymentMethodsView()
                        } label: {
                            AccountRow(title: "Phương thức thanh toán", icon: "icon_bg")
                        }

                        NavigationLink {
                            PromoCodeView()
                        } label: {
                            AccountRow(title: "Mã gỉảm giá", icon: "icon_bg")
                        }
                        NavigationLink {
                            NotificationView()
                        } label: {
                            AccountRow(title: "Thông báo", icon: "icon_bg")
                        }
                        
                        Button {
                            MainViewModel.shared.logout()
                        } label: {
                            ZStack {
                                Text("Đăng xuất")
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.primaryApp)
                                    .multilineTextAlignment(.center)
                                
                                HStack{
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.primaryApp)
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 20)
                                }
                            }
                           
                        }
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                        .background( Color(hex: "F2F3F2"))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    }
                }
            }
            .padding(.bottom, .bottomInsets + 60)
        }
        .ignoresSafeArea()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            AccountView()
        }
        
    }
}
