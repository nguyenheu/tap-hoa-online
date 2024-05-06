//
//  CategoryCell.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 18/04/2024.
//

import SwiftUI

//struct CategoryCell: View {
//    @State var color: Color = Color.yellow
//    var didAddCart: ( ()->() )?
//
//    var body: some View {
//        HStack{
//            ZStack {
//                AsyncImage(url: URL(string: tObj.image )) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                    case .failure(let error):
//                        Text("Failed to load image: \(error.localizedDescription)")
//                    @unknown default:
//                        Text("Unknown state")
//                    }
//                }
//            }
//            .frame(width: 70, height: 70)
//
//            Text(tObj.name)
//                .font(.merriWeather(.bold, fontSize: 16))
//                .foregroundColor(.primaryText)
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//        }
//        .padding(15)
//        .frame(width: 250, height: 100)
//        .background( tObj.color.opacity(0.3) )
//        .cornerRadius(16)
//    }
//}
//
//struct CategoryCell_Previews: PreviewProvider {
//
//}
