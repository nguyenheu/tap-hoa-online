//
//  DeliveryAddressView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct DeliveryAddressView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: AddressModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( addressVM.listArr , id: \.id, content: { aObj in
                        HStack(spacing: 15) {
                            VStack{
                                HStack {
                                    Text(aObj.name)
                                        .font(.merriWeather(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(aObj.typeName)
                                        .font(.merriWeather(.bold, fontSize: 12))
                                        .foregroundColor(.primaryText)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.secondaryText.opacity(0.3))
                                        .cornerRadius(5)
                                }
                                Text("\(aObj.address),\(aObj.city)")
                                    .font(.merriWeather(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .multilineTextAlignment( .leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(aObj.phone)
                                    .font(.merriWeather(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                            }
                            
                            VStack{
                                Spacer()
                                
                                NavigationLink {
                                    AddDeliveryAddressView(isEdit: true, editObj: aObj  )
                                } label: {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.primaryApp)
                                }
                                .padding(.bottom, 8)

                               
                                
                                Button {
                                    addressVM.serviceCallRemove(cObj: aObj)
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if(isPicker) {
                                mode.wrappedValue.dismiss()
                                didSelect?(aObj)
                            }
                        }
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
                    
                    Text("Địa chỉ giao hàng")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                    NavigationLink {
                        AddDeliveryAddressView()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundColor(.primaryText)
                    .padding(.bottom, 8)
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct DeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeliveryAddressView()
        }
    }
}
