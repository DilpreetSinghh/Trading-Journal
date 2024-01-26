//
//  Main App.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// MARK: - Main App Entry Point
@main
struct TraderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - ContentView
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // First section with navigation links
                SectionView(sectionTitle: "Pre-Trade Details", links: ["Planned Buy", "Planned Sell", "Target Prices", "Stop Loss"])

                // Second section with navigation links
                SectionView(sectionTitle: "Post-Trade Analysis", links: ["Actual Buy", "Actual Sell", "Final Results", "Trade Notes"])
            }
            .navigationBarTitle("Trader Dashboard")
        }
    }
}

// MARK: - SectionView
struct SectionView: View {
    var sectionTitle: String
    var links: [String]

    var body: some View {
        Section(header: Text(sectionTitle)) {
            ForEach(links, id: \.self) { link in
                NavigationLink(destination: Text("\(link) Details")) {
                    Text(link)
                }
            }
        }
    }
}

#Preview {
    Main_App()
}
