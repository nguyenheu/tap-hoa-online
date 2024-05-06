//
//  MyOrdersDetailView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct MyOrdersDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM: MyOrderDetailViewModel = MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [:]) )
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack{
                    HStack{
                        Text("ID đơn hàng: # \( detailVM.pObj.id )")
                            .font(.merriWeather(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getPaymentStatus(mObj: detailVM.pObj )  )
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor( getPaymentStatusColor(mObj: detailVM.pObj))
                    }
                    
                    HStack{
                        Text(detailVM.pObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                            .font(.merriWeather(.regular, fontSize: 12))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text( getOrderStatus(mObj: detailVM.pObj )  )
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor( getOrderStatusColor(mObj: detailVM.pObj))
                    }
                    .padding(.bottom, 8)
                    
                    Text("\(detailVM.pObj.address),\(detailVM.pObj.city), \(detailVM.pObj.state), \(detailVM.pObj.postalCode) ")
                        .font(.merriWeather(.regular, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .multilineTextAlignment( .leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack{
                        Text("Loại vận chuyển:")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getDeliveryType(mObj: detailVM.pObj )  )
                            .font(.merriWeather(.regular, fontSize: 16))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Loại thanh toán:")
                            .font(.merriWeather(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getPaymentType(mObj: detailVM.pObj )  )
                            .font(.merriWeather(.regular, fontSize: 16))
                            .foregroundColor( .primaryText )
                    }
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.top, .topInsets + 46)
                
                LazyVStack {
                    ForEach(detailVM.listArr, id: \.id) { pObj in
                        OrderItemRow(pObj: pObj)
                    }
                }
                
                VStack{
                    HStack{
                        Text("Thanh toán:")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text("\( detailVM.pObj.totalPrice, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Phí vận chuyển:")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "+ \( detailVM.pObj.deliverPrice ?? 0.0, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Phí được giảm giá:")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "- \( detailVM.pObj.discountPrice ?? 0.0, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 18))
                            .foregroundColor( .red )
                    }
                    .padding(.bottom, 4)
                    
                    Divider()
                    
                    HStack{
                        Text("Tổng:")
                            .font(.merriWeather(.bold, fontSize: 22))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "\( detailVM.pObj.userPayPrice ?? 0.0, specifier: "%.1f")K")
                            .font(.merriWeather(.bold, fontSize: 22))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
                
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
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Text("Chi tiết đơn hàng")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .foregroundColor(.primaryText)
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $detailVM.showError, content: {
            
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage)  , dismissButton: .default(Text("Ok"))  )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Đã đặt"
        case 2:
            return "Đã chấp nhật";
        case 3:
            return "Đã giao";
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
            return "Thanh toán tiền mặt";
        case 2:
            return "Thanh toán qua thẻ";
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

struct MyOrdersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [
            "order_id": 1,
                        "cart_id": "2",
                        "total_price": 19.9,
                        "user_pay_price": 19.91,
                        "discount_price": 1.99,
                        "deliver_price": 2,
                        "deliver_type": 1,
                        "payment_type": 1,
                        "payment_status": 1,
                        "order_status": 3,
                        "status": 1,
                        "created_date": "2024-04-30 11:03:14",
                        "names": "Súp Lơ",
                        "images": "http://localhost:3001/img/product/20240428081305135YSvnI0SYJp.png",
                        "user_name": "Mat",
                        "phone": "0123456789",
                        "address": "15 Gốc Đề",
                        "city": "Hà Nội",
                        "state":"ok",
                        "postal_code": "987654"
                    
        ])))
    }
}
