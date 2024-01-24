//
//  OSavedNotes.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct OSavedNotes: View {

    @State private var osavedNotes: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let notes = osavedNotes {
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
                loadOSavedNotes()
            }
        }
    }

    private func loadOSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "optionData") {
                // Decode the saved data
                let decoder = JSONDecoder()
                let optionData = try decoder.decode(FutureData.self, from: encodedData)

                // Access the notes property from the decoded data
                osavedNotes = optionData.notes
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

#Preview {
    OSavedNotes()
}
