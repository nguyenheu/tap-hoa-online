//
//  CustomSection.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

struct CustomSection: View {
    var title: String
    var titleButton: String
    var didTap: (()->())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.merriWeather(.bold, fontSize: 20))
                .foregroundColor(.secondaryText)
            Spacer()
            
            Button {
                
            } label: {
                Text(titleButton)
                    .font(.merriWeather(.black, fontSize: 16))
                    .foregroundColor(.primaryApp)
            }
        }
    }
}

struct CustomSection_Previews: PreviewProvider {
    static var previews: some View {
        CustomSection(title: "Title", titleButton: "Button")
    }
}
