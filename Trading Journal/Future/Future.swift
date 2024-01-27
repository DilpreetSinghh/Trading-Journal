//
//  FutureDerivative.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// Define a data model that conforms to Codable
struct FutureDerivativeData: Identifiable, Codable {
    let id: UUID = UUID()
    var selectedDate: Date
    var selectedTime: Date
    var FDSymbol: String
    var FDB_TradingType: String
    var FDI_TradingType: String
    var FDB_BuyPrice: String
    var FDI_BuyPrice: String
    var FDB_SellPrice: String
    var FDI_SellPrice: String
    var FDB_StopLoss: String
    var FDI_StopLoss: String
    var FDB_Qty: String
    var FDI_Qty: String
    var FDB_NetProfit: String
    var FDI_NetProfit: String
    var notes: String
}

struct FutureDerivative: View {
    
    // MARK: - State Variables
    
    @State private var futureDerivativeData = FutureDerivativeData(
        selectedDate: Date(),
        selectedTime: Date(),
        FDSymbol: "",
        FDB_TradingType: "",
        FDI_TradingType: "",
        FDB_BuyPrice: "",
        FDI_BuyPrice: "",
        FDB_SellPrice: "",
        FDI_SellPrice: "",
        FDB_StopLoss: "",
        FDI_StopLoss: "",
        FDB_Qty: "",
        FDI_Qty: "",
        FDB_NetProfit: "",
        FDI_NetProfit: "",
        notes: ""
    )
    
    @State private var showingFDSavedNotes = false
    @State private var fdsavedMessage = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Date and Time Section
                    Group {
                        row(view: AnyView(DatePicker("Date", selection: $futureDerivativeData.selectedDate, in: ...Date(), displayedComponents: .date)))
                        Text("")
                        row(view: AnyView(DatePicker("Time of Trade", selection: $futureDerivativeData.selectedTime, displayedComponents: .hourAndMinute)))
                        row(view: AnyView(HStack {
                            Text("Symbol")
                                .foregroundColor(.primary)
                                .frame(width: 100, alignment: .leading)
                            TextField("Type symbol of stock here", text: $futureDerivativeData.FDSymbol)
                        }))
                    }
                    
                    // Trading Details Section
                    Group {
                        row(view: AnyView(HStack {
                            Text("List").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3))
                            Spacer()
                            Spacer()
                            Text("Planning").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3))
                            Spacer()
                            Text("Implement").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3))
                            Spacer()
                        }))
                        row(view: AnyView(HStack {
                            Text("Type")
                            TextField("Call/Put", text: $futureDerivativeData.FDB_TradingType)
                            TextField("Call/Put", text: $futureDerivativeData.FDI_TradingType)
                        }))
                        row(view: AnyView(HStack {
                            Text("Buy  ")
                            TextField("Buy Price", text: $futureDerivativeData.FDB_BuyPrice)
                            TextField("Buy Price", text: $futureDerivativeData.FDI_BuyPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("Sell  ")
                            TextField("Sell Price", text: $futureDerivativeData.FDB_SellPrice)
                            TextField("Sell Price", text: $futureDerivativeData.FDI_SellPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("SL   ")
                            TextField("Stop Loss", text: $futureDerivativeData.FDB_StopLoss)
                            TextField("Stop Loss", text: $futureDerivativeData.FDI_StopLoss)
                        }))
                        row(view: AnyView(HStack {
                            Text("Qty  ")
                            TextField("Quantity", text: $futureDerivativeData.FDB_Qty)
                            TextField("Quantity", text: $futureDerivativeData.FDI_Qty)
                        }))
                        row(view: AnyView(HStack {
                            Text("Net  ")
                            TextField("Profit/ Loss", text: $futureDerivativeData.FDB_NetProfit)
                            TextField("Profit/ Loss", text: $futureDerivativeData.FDI_NetProfit)
                        }))
                    }
                    
                    // Notes Section
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                        TextEditor(text: $futureDerivativeData.notes)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                            .frame(minHeight: 100)
                        
                        Button("Upload Photo") {
                            self.isShowingImagePicker = true
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImagePicker(selectedImage: $selectedImage)
                        }
                        
                        // Display the selected image if available
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                        }
                        
                    }
                    
                    // Save and Show Saved Notes Buttons
                    Button("Save") {
                        fdSaveData()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    
                    Button("Show Saved Notes") {
                        showingFDSavedNotes = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .sheet(isPresented: $showingFDSavedNotes) {
                        FDSavedNotes()
                    }
                    
                    Text(fdsavedMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding()
            }
            .navigationTitle(Text("Future Derivative"))
        }
    }
    
    // Custom Row Function
    func row<Content: View>(view: Content) -> some View {
        VStack {
            HStack {
                Spacer()
                view
                Spacer()
            }
            Divider().background(Color.gray)
        }
    }
    
    // Save Data Function
    func fdSaveData() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(futureDerivativeData)
            UserDefaults.standard.set(encodedData, forKey: "futureDerivativeData")
            fdsavedMessage = "Data Saved!"
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            fdsavedMessage = "Failed to save data."
        }
    }
    
    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "futureDerivativeData") {
                let decoder = JSONDecoder()
                let futureDerivativeData = try decoder.decode(FutureDerivativeData.self, from: encodedData)
                // Use 'futureDerivativeData' as needed
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

// Preview Section
#if DEBUG
struct FutureDerivative_Previews: PreviewProvider {
    static var previews: some View {
        FutureDerivative()
    }
}
#endif
