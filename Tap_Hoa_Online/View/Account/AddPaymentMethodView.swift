//
//  AddPaymentMethodView.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var payVM = PaymentViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 15){
                    CustomTextField(title: "Tên", placeholder: "Nhập tên" , txt: $payVM.txtName)
                    
                    CustomTextField(title: "Số thẻ", placeholder: "Nhập số thẻ", txt: $payVM.txtCardNumber, keyboardType: .numberPad)

                    HStack{
                        CustomTextField(title: "MM", placeholder: "Nhập tháng" , txt: $payVM.txtCardMonth, keyboardType: .numberPad)
                        CustomTextField(title: "YYYY", placeholder: "Nhập năm" , txt: $payVM.txtCardYear, keyboardType: .numberPad)
                    }
                    
                    RoundButton(title:  "Thêm phương thức thanh toán") {
                            payVM.serviceCallAdd {
                                self.mode.wrappedValue.dismiss()
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
                    
                    Text("Thêm phương thức thanh toán")
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
        
        .alert(isPresented: $payVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(payVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct AddPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentMethodView()
    }
}
