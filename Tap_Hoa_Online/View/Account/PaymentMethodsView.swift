//
//  PaymentMethodsView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct PaymentMethodsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var payVM = PaymentViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PaymentModel) -> () )?
    
    var body: some View {
        ZStack{
            
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( payVM.listArr , id: \.id, content: {
                        pObj in
                        
                        HStack(spacing: 15) {
                                
                            Image("mastercard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            VStack(spacing: 4){
                                Text(pObj.name)
                                    .font(.merriWeather(.bold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text("**** **** **** \(pObj.cardNumber) ")
                                    .font(.merriWeather(.bold, fontSize: 15))
                                    .foregroundColor(.primaryApp)
                                    .multilineTextAlignment( .leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                            }
                            
                            Button {
                                payVM.serviceCallRemove(pObj: pObj)
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.primaryApp)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(15)
                        
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if(isPicker) {
                                mode.wrappedValue.dismiss()
                                didSelect?(pObj)
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
                            .frame(width: 20, height: 20)
                    }
                    Spacer()
                    
                    Text("Phương thức thanh toán")
                        .font(.merriWeather(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    NavigationLink {
                        AddPaymentMethodView( )
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    .foregroundColor(.primaryText)

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
            }
        }
        .alert(isPresented: $payVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(payVM.errorMessage) )
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct PaymentMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            PaymentMethodsView()
        }
        
    }
}
