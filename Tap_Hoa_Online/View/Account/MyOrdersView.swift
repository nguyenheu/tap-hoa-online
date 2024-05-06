//
//  MyOrdersView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct MyOrdersView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var myVM = MyOrdersViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( myVM.listArr, id: \.id, content: {
                        myObj in
                        
                        NavigationLink {
                            MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: myObj) )
                        } label: {
                            VStack{
                                HStack {
                                    Text("Đơn hàng: #")
                                        .font(.merriWeather(.bold, fontSize: 16))
                                        .foregroundColor(.primaryText)
                                    
                                    Text("\(myObj.id)")
                                        .font(.merriWeather(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text(getOrderStatus(mObj: myObj))
                                        .font(.merriWeather(.bold, fontSize: 16))
                                        .foregroundColor( getOrderStatusColor(mObj: myObj) )
                                        
                                }
                                
                                Text(myObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.merriWeather(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                                HStack {
//                                    ZStack {
//                                        AsyncImage(url: URL(string: myObj.image)) { phase in
//                                            switch phase {
//                                            case .empty:
//                                                ProgressView()
//                                            case .success(let image):
//                                                image
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                            case .failure(let error):
//                                                Text("Failed to load image: \(error.localizedDescription)")
//                                            @unknown default:
//                                                Text("Unknown state")
//                                            }
//                                        }
//                                    }
//                                    .frame(width: 60, height: 60)
                                    
                                    VStack{
                                        HStack {
                                            
                                            Text("Mặt hàng:")
                                                .font(.merriWeather(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            
                                            Text(myObj.names)
                                                .font(.merriWeather(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            
                                            Text("Loại giao hàng:")
                                                .font(.merriWeather(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            
                                            Text( self.getDeliveryType(mObj: myObj) )
                                                .font(.merriWeather(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                                                    }
                                        
                                        HStack {
                                            Text("Loại thanh toán:")
                                                .font(.merriWeather(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            
                                            Text(getPaymentType(mObj: myObj))
                                                .font(.merriWeather(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("Trạng thái thanh toán:")
                                                .font(.merriWeather(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            Text( getPaymentStatus(mObj: myObj))
                                                .font(.merriWeather(.bold, fontSize: 14))
                                                .foregroundColor( getPaymentStatusColor(mObj: myObj))
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.primaryApp)
                            .frame(width: 20, height: 20)
                    }
                    Spacer()
                    
                    Text("Đơn hàng")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
            }
        }
        .onAppear{
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Đã đặt"
        case 2:
            return "Chấp nhận";
        case 3:
            return "Đã giao hàng";
        case 4:
            return "Huỷ";
        case 5:
            return "Từ chối";
        default:
            return "";
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
              return "Delivery";
            case 2:
              return "Collection";
        default:
            return "";
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Cash On Delivery";
        case 2:
            return "Online Card Payment";
        default:
            return "";
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Đang xử lý";
        case 2:
            return "Thành công";
        case 3:
            return "Lỗi";
        case 4:
            return "Hoàn tiền";
        default:
            return "";
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.red;
        case 4:
            return Color.green;
        default:
            return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        switch mObj.orderStatus {
        case 1:
              return Color.blue;
            case 2:
              return Color.green;
            case 3:
              return Color.green;
            case 4:
              return Color.red;
            case 5:
              return Color.red;
            default:
              return Color.primaryApp;        }
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyOrdersView()
        }
       
    }
}
