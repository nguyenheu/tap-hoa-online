//
//  ProductCell.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 18/04/2024.
//

import SwiftUI

struct ProductCell: View {
    @State var pObj: ProductModel = ProductModel(dict: [:])
    var width:Double = 180.0
    var didAddCart: ( ()->() )?
    
    var body: some View {
        NavigationLink {
            ProductDetailView(detailVM: ProductDetailViewModel(prodObj: pObj) )
        } label: {
            VStack{
                ZStack {
                    AsyncImage(url: URL(string: pObj.image )) { phase in
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
                .frame(width: 100, height: 80)
                
                Spacer()
                
                Text(pObj.name)
                    .font(.merriWeather(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(pObj.unitValue)\(pObj.unitName), giá")
                    .font(.merriWeather(.bold, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack{
                    Text("\(pObj.offerPrice ?? pObj.price, specifier: "%.1f" )K")
                        .font(.merriWeather(.bold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        didAddCart?()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background( Color.primaryApp)
                    .cornerRadius(15)
                }
            }
            .padding(15)
            .frame(width: width, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell()
    }
}
