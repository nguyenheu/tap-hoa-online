//
//  ChangePasswordView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var myVM = MyDetailsViewModel.shared

    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15){
                    
                    
                    CustomSecureField( title: "Mật khẩu hiện tại", placeholder: "Nhập mật khẩu hiện tại", txt: $myVM.txtCurrentPassword, isShowPassword: $myVM.isCurrentPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    CustomSecureField( title: "Mật khẩu mới", placeholder: "Nhập mật khẩu mới", txt: $myVM.txtNewPassword, isShowPassword: $myVM.isNewPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    CustomSecureField( title: "Xác thực mật khẩu", placeholder: "Xác thực mật khẩu mới", txt: $myVM.txtConfirmPassword, isShowPassword: $myVM.isConfirmPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    RoundButton(title: "Cập nhật") {
                        myVM.serviceCallChangePassword()
                    }
                    .padding(.bottom, 45)

                }
                .padding(20)
                .padding(.top, .topInsets + 60)
            }
            
            VStack {
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.primaryApp)
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Text("Thay đổi mật khẩu")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
                
            }
        }
        .alert(isPresented: $myVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(myVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
