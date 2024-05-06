//
//  RoundButton.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 14/04/2024.
//

import SwiftUI

struct RoundButton: View {
    var title: String
    var didTap: (() -> ())?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.merriWeather(.black, fontSize: 18))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .background(Color.primaryApp)
        .cornerRadius(12)
        .padding()
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton(title: "Get Started")
    }
}
