//
//  Trading_JournalApp.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 07/01/24.
//

import SwiftUI

@main
struct Trading_Journal: App {
    @StateObject var viewModel = SharedViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                TradingStyle()
                    .environmentObject(viewModel) // Adding the ViewModel to the environment
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }

                Recent()
                    .environmentObject(viewModel) // Adding the ViewModel to the environment
                    .tabItem {
                        Label("Recent", systemImage: "clock")
                    }
            }
        }
    }
}



