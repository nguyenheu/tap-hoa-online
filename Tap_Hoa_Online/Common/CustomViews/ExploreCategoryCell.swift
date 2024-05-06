//
//  ExploreCategoryCell.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

import SwiftUI

struct ExploreCategoryCell: View {
    @State var cObj: ExploreCategoryModel = ExploreCategoryModel(dict: [ : ])
   
   
    
    var body: some View {
        VStack{
            
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
            .frame(width: 120, height: 90)
            
        
            Spacer()
            Text(cObj.name)
                .font(.merriWeather(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
        .background( cObj.color.opacity(0.3) )
        .cornerRadius(16)
        .overlay (
            RoundedRectangle(cornerRadius: 16)
                .stroke(cObj.color, lineWidth: 1)
        )
    }}

struct ExploreCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCategoryCell(cObj: ExploreCategoryModel(dict: [ "cat_id": 1,
                                                               "cat_name": "Pulses",
                                                               "image": "http://192.168.1.3:3001/img/type/202307261610181018aVOpgmY1W1.png",
                                                               "color": "F8A44C"]) )
        .padding(20)
    }
}
