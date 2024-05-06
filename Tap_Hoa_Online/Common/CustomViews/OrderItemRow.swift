//
//  OrderItemRow.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct OrderItemRow: View {
    @State var pObj: OrderItemModel = OrderItemModel(dict: [:])
    
    var body: some View {
        
            HStack(spacing: 15){
                ZStack {
                    AsyncImage(url: URL(string: pObj.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(let error):
                            Text("Failed to load image: \(error.localizedDescription)")
                        @unknown default:
                            Text("Unknown state")
                        }
                    }
                }
                .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(pObj.name)
                        .font(.merriWeather(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(pObj.unitValue)\(pObj.unitName), giá")
                        .font(.merriWeather(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Số lượng:")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.qty )")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("×")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.itemPrice, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("\(pObj.offerPrice ?? pObj.price, specifier: "%.1f")K")
                    .font(.merriWeather(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.15), radius: 2)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        
    }
}

struct OrderItemRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow()
    }
}
