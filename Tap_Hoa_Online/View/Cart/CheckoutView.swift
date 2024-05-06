//
//  CheckoutView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct CheckoutView: View {
    
    @Binding var isShow: Bool
    @StateObject var cartVM = CartViewModel.shared
  
    var body: some View {
        VStack {
            
            Spacer()
            VStack{
                HStack{
                    Text("Thanh toán")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    Button {
                        $isShow.wrappedValue = false
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                }
                .padding(.top, 30)
                
                Divider()
                
                
                VStack{
                    HStack {
                        Text("Loại vận chuyển")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Picker("",  selection: $cartVM.deliveryType) {
                            Text("Delivery").tag(1)
                            Text("Collection").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }
                    
                    Divider()
                    
                    if(cartVM.deliveryType == 1) {
                        
                        NavigationLink {
                            DeliveryAddressView(isPicker: true, didSelect: {
                                aObj in
                                cartVM.deliverObj = aObj
                            } )
                        } label: {
                            HStack {
                                Text("Vận chuyển")
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Text( cartVM.deliverObj?.name ?? "Chọn phương thức")
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.primaryText)
                            }
                        }
                        Divider()
                    }
                    
                    
                    HStack {
                        Text("Loại thanh toán")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Picker("",  selection: $cartVM.paymentType) {
                            Text("COD").tag(1)
                            Text("Online").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 150)
                    }
                    
                    Divider()
                    if(cartVM.paymentType == 2) {
                        
                        NavigationLink {
                            PaymentMethodsView(isPicker: true, didSelect: {
                                pObj in
                                cartVM.paymentObj = pObj
                            } )
                        } label: {
                            HStack {
                                Text("Thanh toán")
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 20)
                                
                                Text( cartVM.paymentObj?.cardNumber ?? "Chọn")
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.primaryText)
                                
                            }
                        }
                        
                        Divider()
                    }
                    
                    NavigationLink {
                        PromoCodeView(isPicker: true, didSelect: {
                            pObj in
                            cartVM.promoObj = pObj
                        })
                    } label: {
                        HStack {
                            Text("Mã giảm giá")
                                .font(.merriWeather(.bold, fontSize: 18))
                                .foregroundColor(.secondaryText)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            
                            
                            Text( cartVM.promoObj?.code  ?? "Chọn mã")
                                .font(.merriWeather(.regular, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primaryText)
                            
                        }
                    }
                    
                    Divider()
                }
                
                VStack{
                    HStack {
                        Text("Tổng tiền")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("\(cartVM.total)K")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                    }
                    
                    HStack {
                        Text("Phí vận chuyển")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("+ \(cartVM.deliverPriceAmount)K")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                    }
                    
                    HStack {
                        Text("Giảm")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("- \(cartVM.discountAmount)K")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.red)
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
                
                HStack {
                    Text("Tổng hoá đơn")
                        .font(.merriWeather(.bold, fontSize: 18))
                        .foregroundColor(.secondaryText)
                        .frame(height: 46)
                    
                    Spacer()
                    
                    
                    
                    Text("\(cartVM.userPayAmount)K")
                        .font(.merriWeather(.bold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(height: 46)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primaryText)
                    
                }
                Divider()
                
                RoundButton(title: "Đặt hàng") {
                    cartVM.serviceCallOrderPlace()
                }
                .padding(.bottom, .bottomInsets + 70)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20, corner: [.topLeft, .topRight])
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    @State static var isShow: Bool = false;
    static var previews: some View {
        NavigationView {
            CheckoutView(isShow: $isShow)
        }
        
    }
}
