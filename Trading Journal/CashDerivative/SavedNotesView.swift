//
//  SavedNotesView.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//
import SwiftUI

struct SavedNotesView: View {

    @State private var savedNotes: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let notes = savedNotes {
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
                loadSavedNotes()
            }
        }
    }

    private func loadSavedNotes() {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Get a list of all files in the document directory
                let fileURLs = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)

                // Find the latest file based on modification date
                if let latestFile = fileURLs.max(by: { $0.lastPathComponent < $1.lastPathComponent }) {
                    // Read the contents of the file into a string
                    savedNotes = try String(contentsOf: latestFile, encoding: .utf8)
                }
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}


#Preview {
    SavedNotesView()
}
