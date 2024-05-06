//
//  FavouriteRow.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct FavouriteRow: View {
    @State var fObj: ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                ZStack {
                    AsyncImage(url: URL(string: fObj.image )) { phase in
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
                    
                    Text(fObj.name)
                        .font(.merriWeather(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObj.unitValue)\(fObj.unitName), giá")
                        .font(.merriWeather(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("\(fObj.offerPrice ?? fObj.price, specifier: "%.1f")K")
                    .font(.merriWeather(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
                
            }
            Divider()
        }
    }
}

struct FavouriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRow()
    }
}
