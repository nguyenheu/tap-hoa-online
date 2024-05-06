//
//  Tap_Hoa_OnlineApp.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 11/04/2024.
//

import SwiftUI

@main
struct Tap_Hoa_OnlineApp: App {
    @StateObject private var mainVM = MainViewModel.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if mainVM.isUserLogin {
                    MainTabView()
                } else {
                    OnboardingView()
                }
            }
            
        }
    }
}
