//
//  CartItemRow.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct CartItemRow: View {
    @State var cObj: CartItemModel = CartItemModel(dict: [:])
    
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                ZStack {
                    AsyncImage(url: URL(string: cObj.image )) { phase in
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
                    
                    HStack {
                        Text(cObj.name)
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            CartViewModel.shared.serviceCallRemove(cObj: cObj)
                        } label: {
                            Image(systemName: "multiply.circle")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }

                    }
                   
                    
                    Text("\(cObj.unitValue)\(cObj.unitName), giá")
                        .font(.merriWeather(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    
                    HStack{
                        Button {
                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty - 1)
                        } label: {
                            
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.primaryApp)
                                .frame(width: 16, height: 16)
                                .padding(8)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Text( "\(cObj.qty)" )
                            .font(.merriWeather(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            
                        
                        Button {
                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty + 1)
                        } label: {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.primaryApp)
                                .frame(width: 16, height: 16)
                                .padding(8)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Text("\(cObj.offerPrice ?? cObj.price, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                    }
                    
                }
                
                
                
            }
            Divider()
        }
    }
}

struct CartItemRow_Previews: PreviewProvider {
    static var previews: some View {
        CartItemRow(cObj: CartItemModel(dict: [
            "cart_id": 4,
            "user_id": 2,
            "prod_id": 9,
            "qty": 1,
            "cat_id": 1,
            "name": "Su Su",
            "detail": "Su su là một loại rau quả có hình dáng hơi giống quả bí, có màu xanh nhạt hoặc trắng nhạt. Su su được sử dụng phổ biến trong nhiều nền văn hóa ẩm thực với hương vị nhẹ nhàng và chứa nhiều chất dinh dưỡng.",
            "unit_name": "g",
            "unit_value": "500",
            "nutrition_weight": "100",
            "price": 19.9,
            "created_date": "2024-04-28 08:16:25",
            "modify_date": "2024-04-28 08:16:25",
            "cat_name": "Rau củ",
            "is_fav": 0,
            "offer_price": 19.9,
            "start_date": "2024-05-01 00:00:00",
            "end_date": "2024-06-01 00:00:00",
            "is_offer_active": 1,
            "image": "http://localhost:3001/img/product/202404280816251625k1P36XX9nP.jpeg",
            "item_price": 19.9,
            "total_price": 19.9
                   ]))
        .padding(.horizontal, 20)
    }
}
