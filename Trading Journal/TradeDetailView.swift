//
//  TradeDetailView.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

protocol TradeDetailViewProtocol {
    init(tradeType: String)
}

// Ensure your TradeDetailView conforms to this protocol
struct TradeDetailView: View, TradeDetailViewProtocol {
    var tradeType: String

        // Implement the required initializer
        init(tradeType: String) {
            self.tradeType = tradeType
            // Initialize any other properties if needed
        }

    var coreDataManager = CoreDataManager.shared
    
    @State private var symbol: String = ""
    @State private var plannedPrice: String = ""  // Use a String for TextField binding
    @State private var actualPrice: String = ""   // Use a String for TextField binding
    @State private var notes: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false


    var body: some View {
        Form {
            Section(header: Text("Trade Details")) {
                TextField("Symbol", text: $symbol)
                TextField("Planned Price", text: $plannedPrice)
                TextField("Actual Price", text: $actualPrice)
                TextField("Notes", text: $notes)
            }
            Section(header: Text("Image")) {
                Button("Select Image") {
                    isImagePickerPresented = true
                }
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            Section {
                Button("Save") {
                    saveNote()
                }
                .disabled(symbol.isEmpty || plannedPrice.isEmpty || actualPrice.isEmpty)
            }
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .navigationBarTitle("\(tradeType) Details")
    }
    func saveNote() {
        let context = coreDataManager.persistentContainer.viewContext
        let newNote = TradeNote(context: managedObjectContext)
            newNote.symbol = symbol
            newNote.plannedPrice = Double(plannedPrice) ?? 0.0  // Convert the String to a Double
            newNote.actualPrice = Double(actualPrice) ?? 0.0    // Convert the String to a Double
            newNote.notes = notes
        if let selectedImage = selectedImage, let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
                newNote.image = imageData
            }
            
            // Attempt to save the context
            do {
                try context.save()
            } catch {
                // Handle the error, e.g., show an error message to the user
                print("Could not save the note: \(error.localizedDescription)")
            }

        coreDataManager.saveContext()
    }

}
// MARK: - SectionView
struct SectionView<T: TradeDetailViewProtocol>: View {
    var sectionTitle: String
    var links: [String]
    
    var viewType: T.Type
    var body: some View {
        Section(header: Text(sectionTitle)) {
            ForEach(links, id: \.self) { link in
                NavigationLink(destination: viewType.init(tradeType: link)) {
                    Text(link)
                }
            }
        }
    }
}

