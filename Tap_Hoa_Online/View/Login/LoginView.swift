//
//  LoginView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 13/04/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = MainViewModel.shared
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryApp.opacity(0.95).ignoresSafeArea()
                Image(AppImage.Image.bg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Đăng nhập")
                        .font(.merriWeather(.black, fontSize: 26))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                    Text("Nhập địa chỉ email và mật khẩu để truy cập vào tài khoản của bạn hoặc tạo một tài khoản mới")
                        .font(.merriWeather(.regular, fontSize: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                    VStack {
                        CustomTextField(title: "Email", placeholder: "Nhập email", txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                            .padding(.bottom)
                        
                        CustomSecureField(title: "Mật khẩu", placeholder: "Nhập mật khẩu", txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                        
                        NavigationLink {
                            ForgotPassword()
                        } label: {
                            Text("Quên mật khẩu")
                                .font(.merriWeather(.bold, fontSize: 14))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .trailing)
                        }
                        
                        RoundButton(title: "Đăng nhập") {
                            loginVM.serviceCallLogin()
                        }
                        
                        HStack {
                            Text("Không có tài khoản?")
                                .font(.merriWeather(.regular, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            NavigationLink {
                                SignUpView()
                            } label: {
                                Text("Đăng ký")
                                    .font(.merriWeather(.bold, fontSize: 14))
                                    .foregroundColor(.primaryApp)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
