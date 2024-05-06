//
//  ProductDetailView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 18/04/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var detailVM: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]) )
    
    var body: some View {
        ZStack{
            
            ScrollView {
                ZStack{
                    Rectangle()
                        .foregroundColor( Color(hex: "F2F2F2") )
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                    ZStack {
                        AsyncImage(url: URL(string: detailVM.pObj.image )) { phase in
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
                    .frame(width: .screenWidth * 0.7, height: .screenWidth * 0.7)
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.7)
                
                VStack{
                    HStack{
                        Text(detailVM.pObj.name)
                            .font(.merriWeather(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Button {
                            detailVM.serviceCallAddRemoveFav()
                        } label: {
                            
                            Image(systemName: detailVM.isFav ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .foregroundColor(Color.primaryApp)

                    }
                    Text("\(detailVM.pObj.unitValue)\(detailVM.pObj.unitName), Giá")
                        .font(.merriWeather(.bold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Button {
                            detailVM.addSubQTY(isAdd: false)
                        } label: {
                            
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .padding(10)
                        }
                        .foregroundColor(Color.primaryApp)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Text( "\(detailVM.qty)")
                            .font(.merriWeather(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                        
                        Button {
                            detailVM.addSubQTY(isAdd: true)
                        } label: {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .padding(10)
                        }
                        .foregroundColor(Color.primaryApp)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Text( "\(  (detailVM.pObj.offerPrice ?? detailVM.pObj.price) * Double(detailVM.qty) , specifier: "%.1f")K"  )
                            .font(.merriWeather(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                            
                    }
                    .padding(.vertical, 8)
                }
                .padding([.horizontal, .top])
                
                VStack{
                    HStack{
                        Text("Chi tiết sản phẩm")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            withAnimation {
                                detailVM.showDetail()
                            }
                        } label: {
                            Image(systemName: detailVM.isShowDetail ? "chevron.down" : "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if(detailVM.isShowDetail) {
                        Text(detailVM.pObj.detail)
                            .font(.merriWeather(.regular, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom , 8)
                    }
                }
                .padding(.horizontal)
                
                VStack{
                    HStack{
                        Text("Dinh dưỡng")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        
                        Text(detailVM.pObj.nutritionWeight)
                            .font(.merriWeather(.bold, fontSize: 10))
                            .foregroundColor(.secondaryText)
                            .padding(8)
                            .background( Color.placeholder.opacity(0.5) )
                            .cornerRadius(5)
                        
                        Button {
                            withAnimation {
                                detailVM.showNutrition()
                            }
                            
                        } label: {
                            Image(systemName: detailVM.isShowNutrition ? "chevron.down" : "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    .padding(.vertical)
                    
                    if(detailVM.isShowNutrition) {
                        LazyVStack(spacing: 6) {
                            ForEach( detailVM.nutritionArr , id: \.id) { nObj in
                                HStack{
                                    Text( nObj.nutritionName )
                                        .font(.merriWeather(.bold, fontSize: 15))
                                        .foregroundColor(.secondaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text( nObj.nutritionValue )
                                        .font(.merriWeather(.bold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal)
                
                HStack{
                    Text("Đánh giá")
                        .font(.merriWeather(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 2){
                        ForEach( 1...5 , id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.orange)
                                .frame(width: 15, height: 15)
                        }
                    }
                    
                    Button {
                       
                    } label: {
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .foregroundColor(Color.primaryText)
                }
                .padding(.horizontal)
                
                RoundButton(title: "Thêm vào giỏ hàng") {
                    CartViewModel.serviceCallAddToCart(prodId: detailVM.pObj.prodId, qty: detailVM.qty) { isDone, msg  in
                        detailVM.qty = 1

                        self.detailVM.errorMessage = msg
                        self.detailVM.showError = true
                    }
                }
                .padding()
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.primaryApp)
                    .frame(width: 25, height: 25)
                    .padding(.top, .topInsets)
                    .padding(.leading)
            }
        }
        .alert(isPresented: $detailVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage), dismissButton: .default(Text("Ok"))  )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(detailVM: ProductDetailViewModel(prodObj: ProductModel(dict: [
            "offer_price": 19.9,
            "start_date": "2024-05-01 00:00:00",
            "end_date": "2024-06-01 00:00:00",
            "prod_id": 9,
            "cat_id": 1,
            "name": "Su Su",
            "detail": "Su su là một loại rau quả có hình dáng hơi giống quả bí, có màu xanh nhạt hoặc trắng nhạt. Su su được sử dụng phổ biến trong nhiều nền văn hóa ẩm thực với hương vị nhẹ nhàng và chứa nhiều chất dinh dưỡng.",
            "unit_name": "g",
            "unit_value": "500",
            "nutrition_weight": "100",
            "price": 19.9,
            "image": "http://localhost:3001/img/product/202404280816251625k1P36XX9nP.jpeg",
            "cat_name": "Rau củ",
            "is_fav": 0
        ])))
    }
}
