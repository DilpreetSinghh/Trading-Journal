//
//  CCSavedNotes.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct CCSavedNotes: View {

    @State private var ccsavedNotes: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let notes = ccsavedNotes {
                        Text("Recently Saved Notes:")
                            .font(.headline)
                        Text(notes)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                    } else {
                        Text("No saved notes available.")
                    }
                }
                .padding()
            }
            .navigationTitle("Saved Notes")
            .onAppear {
                loadCCSavedNotes()
            }
        }
    }

    private func loadCCSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cryptocurrencyData") {
                // Decode the saved data
                let decoder = JSONDecoder()
                let cryptocurrencyData = try decoder.decode(FutureData.self, from: encodedData)

                // Access the notes property from the decoded data
                ccsavedNotes = cryptocurrencyData.notes
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}
#Preview {
    CCSavedNotes()
}
