//
//  ExploreView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 17/04/2024.
//

import SwiftUI

import SwiftUI

struct ExploreView: View {
    @StateObject var explorVM = ExploreViewModel.shared
    @State var txtSearch: String = ""
    
    var colums =  [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Text("Tìm kiếm sản phẩm")
                    .font(.merriWeather(.bold, fontSize: 20))
                    .frame(height: 46)
                    .padding(.top, .topInsets)
                
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                    
                    CustomTextField(placeholder: "Tìm kiếm", txt: $txtSearch)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 4)
                
                
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 20) {
                        ForEach(explorVM.listArr, id: \.id) { cObj in
                            NavigationLink(destination: ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: cObj) ) ) {
                                ExploreCategoryCell(cObj: cObj)
                                    .aspectRatio( 0.95, contentMode: .fill)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
                
            }
            
        }
        .ignoresSafeArea()
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExploreView()
        }
        
    }
}
