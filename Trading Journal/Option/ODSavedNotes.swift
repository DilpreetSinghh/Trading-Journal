//
//  OSavedNotes.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct ODSavedNotes: View {

    @State private var odsavedNotes: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let notes = odsavedNotes {
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
                loadODSavedNotes()
            }
        }
    }

    private func loadODSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "optionDerivativeData") {
                let decoder = JSONDecoder()
                let optionData = try decoder.decode(OptionDerivativeData.self, from: encodedData)
                odsavedNotes = optionData.notes
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ODSavedNotes()
}
