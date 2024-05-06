//
//  UITextField.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 14/04/2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String?
    var placeholder: String
    @Binding var txt: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title ?? "")
                .font(.merriWeather(.bold, fontSize: 16))
                .foregroundColor(Color.textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            TextField(placeholder, text: $txt)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom)
            
            Divider()
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static  var txt: String = ""
    static var previews: some View {
        CustomTextField(title: "test", placeholder: "Search", txt: $txt)
    }
}

struct CustomSecureField: View {
    var title: String
    var placeholder: String
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.merriWeather(.bold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            if (isShowPassword) {
                TextField(placeholder, text: $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .modifier( ShowButton(isShow: $isShowPassword))
                    .padding(.bottom)
            }else{
                SecureField(placeholder, text: $txt)
                    .autocapitalization(.none)
                     .modifier( ShowButton(isShow: $isShowPassword))
                     .padding(.bottom)
            }
            
            Divider()
        }
    }
}
