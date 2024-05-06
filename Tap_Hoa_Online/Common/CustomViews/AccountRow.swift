//
//  AccountRow.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct AccountRow: View {
    @State var title: String = "Title"
    @State var icon: String = "icon_bg"
    
    var body: some View {
        VStack{
            
            HStack(spacing: 15){
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20 )
                
                Text(title)
                    .font(.merriWeather(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15 )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            Divider()
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow()
    }
}
