//
//  AddDeliveryAddressView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isEdit: Bool = false
    @State var editObj: AddressModel?
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 15){
                    HStack{
                        Button {
                            addressVM.txtTypeName = "Nhà"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Nhà" ? "record.circle" : "circle"  )
                                
                            Text("Nhà")
                                .font(.merriWeather(.bold, fontSize: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.primaryText)
                        
                        Button {
                            addressVM.txtTypeName = "Cơ quan"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Cơ quan" ? "record.circle" : "circle"  )
                                
                            Text("Cơ quan")
                                .font(.merriWeather(.bold, fontSize: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                        }
                        .foregroundColor(.primaryText)
                    }
                    
                    CustomTextField(title: "Tên", placeholder: "Nhập tên" , txt: $addressVM.txtName)
                    
                    CustomTextField(title: "Số điện thoại", placeholder: "Nhập số điện thoại", txt: $addressVM.txtMobile, keyboardType: .numberPad)
                    
                    CustomTextField(title: "Địa chỉ", placeholder: "Nhập địa chỉ" , txt: $addressVM.txtAddress)
                    
                    RoundButton(title: isEdit ? "Cập nhật địa chỉ" : "Thêm địa chỉ") {
                        if(isEdit) {
                            addressVM.serviceCallUpdateAddress(aObj: editObj) {
                                self.mode.wrappedValue.dismiss()
                            }
                        }else{
                            addressVM.serviceCallAddAddress {
                                self.mode.wrappedValue.dismiss()
                            }
                        }
                    }
                    
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
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
                    
                    Text( isEdit ? "Sửa địa chỉ giao hàng" : "Thêm địa chỉ giao hàng")
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
            if(isEdit) {
                if let aObj = editObj {
                    addressVM.setData(aObj: aObj)
                }
            }
        }
        .alert(isPresented: $addressVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(addressVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct AddDeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeliveryAddressView()
    }
}
