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
                SectionView(sectionTitle: "Pre-Trade Details", links: ["Planned Buy", "Planned Sell", "Target Prices", "Stop Loss"], viewType: TradeDetailView.self)
                SectionView(sectionTitle: "Post-Trade Analysis", links: ["Actual Buy", "Actual Sell", "Final Results", "Trade Notes"], viewType: TradeDetailView.self)
            }
            .navigationBarTitle("Trader Dashboard")
        }
    }
}



// MARK: - MainView with TabView
struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            RecentView()
                .tabItem {
                    Label("Recent", systemImage: "clock")
                }
        }
    }
}

// MARK: - RecentView
struct RecentView: View {
    @State private var recentNotes: [TradeNote] = []
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ForEach(recentNotes.filter { searchText.isEmpty || "\($0.symbol)".contains(searchText) }, id: \.self) { note in
                // Display each note's details
            }
        }
        .onAppear {
            recentNotes = CoreDataManager.shared.fetchRecentNotes()
                
        }
        List {
            ForEach(recentNotes, id: \.self) { note in
                // Display each note's details
            }
            .onDelete(perform: deleteNote) // Correct placement of onDelete
        }
    }
    private func deleteNote(at offsets: IndexSet) {
            offsets.forEach { index in
                // Logic to delete note from Core Data
            }
        }
}


#Preview {
    TraderApp() as! any View
}
