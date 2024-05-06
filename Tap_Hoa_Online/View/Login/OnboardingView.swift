//
//  OnboardingView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 14/04/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isLoading = false
    @State private var isLogin = false
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Image(AppImage.Image.gro_bg)
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack(alignment: .center, spacing: 16) {
                Image(AppImage.Image.carrot)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 48)
                
                Text("Tạp hoá Eco \nXin chào")
                    .font(.merriWeather(.black, fontSize: 36))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                Text( "Nhận được hàngcủa bạn \nchỉ trong vòng một giờ")
                    .font(.merriWeather(.bold, fontSize: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                Button {
                    self.isLoading = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.isLoading = false
                        self.isLogin = true
                    }
                } label: {
                    ZStack {
                        if isLoading {
                            HStack(alignment: .center, spacing: 16) {
                                ProgressView()
                                
                                Text("Vui lòng chờ...")
                            }
                            
                        } else {
                            Text("Started")
                        }
                    }
                    .font(.merriWeather(.black, fontSize: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .background(Color.primaryApp)
                .cornerRadius(12)
                .padding()
                .fullScreenCover(isPresented: $isLogin) {
                    LoginView()
                }
            }
            .padding(.bottom, 120)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
