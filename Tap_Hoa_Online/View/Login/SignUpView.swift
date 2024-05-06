//
//  SignUpView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 14/04/2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var signUp = MainViewModel.shared
    @Environment(\.presentationMode) var presentationMode
    
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
                    
                    Text("Đăng ký")
                        .font(.merriWeather(.black, fontSize: 26))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                    
                    Text("Để nhận được nhiều ưu đãi hơn, đăng ký tài khoản của bạn bằng cách điền thông tin")
                        .font(.merriWeather(.regular, fontSize: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                    VStack {
                        CustomTextField(title: "Username", placeholder: "Nhập username", txt: $signUp.txtUsername)
                            .padding(.bottom)
                        
                        CustomTextField(title: "Email", placeholder: "Nhập email", txt: $signUp.txtEmail, keyboardType: .emailAddress)
                            .padding(.bottom)
                        
                        CustomSecureField(title: "Mật khẩu", placeholder: "Nhập mật khẩu", txt: $signUp.txtPassword, isShowPassword: $signUp.isShowPassword)
                        
                        RoundButton(title: "Đăng ký") {
                            signUp.serviceCallSignUp()
                        }
                        
                        HStack {
                            Text("Đã có tài khoản?")
                                .font(.merriWeather(.regular, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Đăng nhập")
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
                .padding()
            }
        }
        .alert(isPresented: $signUp.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(signUp.errorMessage) , dismissButton: .default(Text("Ok")))
        })
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
