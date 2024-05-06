//
//  MyDetailsView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct MyDetailsView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var myVM = MyDetailsViewModel.shared

    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15){
                    CustomTextField(title: "Tên", placeholder: "Nhập tên" , txt: $myVM.txtName)
                    
                    VStack {
                        Text("Số điện thoại")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.textTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                    }
                    
                    CustomTextField(title: "User name", placeholder: "Nhập user name" , txt: $myVM.txtUsername)
   
                    RoundButton(title: "Cập nhật") {
                        myVM.serviceCallUpdate()
                    }
                    .padding(.bottom, 45)
                    
                    NavigationLink {
                        ChangePasswordView()
                    } label: {
                        Text("Thay đổi mật khẩu")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)

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
                    
                    Text( "Thông tin chi tiết")
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
        
//        .sheet(isPresented: $myVM.isShowPicker, content: {
//            CountryPickerUI(country: $myVM.countryObj)
//        })
        .alert(isPresented: $myVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(myVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDetailsView()
    }
}
