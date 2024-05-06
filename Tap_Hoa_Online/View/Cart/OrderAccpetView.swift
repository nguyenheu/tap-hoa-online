//
//  OrderAccpetView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct OrderAccpetView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            Color.primaryApp.opacity(0.75).ignoresSafeArea()
            Image("bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                Image("icon_bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.7)
                    .padding(.bottom, 32)
                
                Text("Đơn hàng của bạn \n được chấp nhận")
                    .multilineTextAlignment(.center)
                    .font(.merriWeather(.bold, fontSize: 28))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                
                Text("Sản phẩm đã được đặt và đang trong quá trình xử lý")
                    .multilineTextAlignment(.center)
                    .font(.merriWeather(.regular, fontSize: 16))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                
                Spacer()
                
                Spacer()
                
                RoundButton(title: "Track Order") {
                    mode.wrappedValue.dismiss()
                }
                
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Trở về")
                        .font(.merriWeather(.bold, fontSize: 18))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                }
                .padding(.bottom , .bottomInsets + 15)

            }
            .padding(.horizontal, 20)
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct OrderAccpetView_Previews: PreviewProvider {
    static var previews: some View {
        OrderAccpetView()
    }
}
