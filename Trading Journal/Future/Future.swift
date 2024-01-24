//
//  Future.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// Define a data model that conforms to Codable
struct FutureData: Codable {
    var selectedDate: Date
    var selectedTime: Date
    var CDSymbol: String
    var CDB_TradingType: String
    var CDI_TradingType: String
    var CDB_BuyPrice: String
    var CDI_BuyPrice: String
    var CDB_SellPrice: String
    var CDI_SellPrice: String
    var CDB_StopLoss: String
    var CDI_StopLoss: String
    var CDB_Qty: String
    var CDI_Qty: String
    var CDB_NetProfit: String
    var CDI_NetProfit: String
    var notes: String
}

struct Future: View {
    
    // MARK: - State Variables
    
    // New data model instance
    @State private var futureData = FutureData(
        selectedDate: Date(),
        selectedTime: Date(),
        CDSymbol: "",
        CDB_TradingType: "",
        CDI_TradingType: "",
        CDB_BuyPrice: "",
        CDI_BuyPrice: "",
        CDB_SellPrice: "",
        CDI_SellPrice: "",
        CDB_StopLoss: "",
        CDI_StopLoss: "",
        CDB_Qty: "",
        CDI_Qty: "",
        CDB_NetProfit: "",
        CDI_NetProfit: "",
        notes: ""
    )
    
    // Show saved notes
    @State private var showingFSavedNotes = false
    
    // Saved message
    @State private var fsavedMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    // MARK: - Date and Time Section
                    
                    Group {
                        // Date picker for selecting a date
                        row(view: AnyView(DatePicker("Date", selection: $futureData.selectedDate, in: ...Date(), displayedComponents: .date)))
                        
                        // Time picker for selecting a time
                        Text("Time of Trade")
                            .font(.headline)
                            .padding(.vertical, 5)
                        row(view: AnyView(DatePicker("", selection: $futureData.selectedTime, in: ...Date(), displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())))
                        
                        // Text field for typing the symbol
                        row(view: AnyView(HStack {
                            Text("Symbol")
                                .foregroundColor(.primary)
                                .frame(width: 100, alignment: .leading) // Adjust width as needed
                            TextField("Type symbol of stock here", text: $futureData.CDSymbol)
                        }))
                    }
                    
                    // MARK: - Trading Details Section
                    
                    Group {
                        // Horizontal stack for displaying "Before" and "After" labels
                        row(view: AnyView(HStack {
                            Text("List").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3)) // Background color
                            
                            Spacer()
                            Spacer()
                            
                            Text("Planning").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3)) // Background color
                            Spacer()
                            
                            Text("Implement").frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.gray.opacity(0.3)) // Background color
                            Spacer()
                        }))
                        
                        // Trading type, buy and sell price, stop loss, quantity, and net profit/loss for both Before (B) and After (A)
                        row(view: AnyView(HStack {
                            Text("Type")
                            TextField("Buy/Sell", text: $futureData.CDB_TradingType)
                            TextField("Buy/Sell", text: $futureData.CDI_TradingType)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Buy  ")
                            TextField("Buy Price", text: $futureData.CDB_BuyPrice)
                            TextField("Buy Price", text: $futureData.CDI_BuyPrice)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Sell  ")
                            TextField("Sell Price", text: $futureData.CDB_SellPrice)
                            TextField("Sell Price", text: $futureData.CDI_SellPrice)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("SL   ")
                            TextField("Stop Loss", text: $futureData.CDB_StopLoss)
                            TextField("Stop Loss", text: $futureData.CDI_StopLoss)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Qty  ")
                            TextField("Quantity", text: $futureData.CDB_Qty)
                            TextField("Quantity", text: $futureData.CDI_Qty)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Net  ")
                            TextField("Profit/ Loss", text: $futureData.CDB_NetProfit)
                            TextField("Profit/ Loss", text: $futureData.CDI_NetProfit)
                        }))
                    }
                    
                    // Text editor for notes
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                        TextEditor(text: $futureData.notes)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                            .frame(minHeight: 100)
                    }
                    
                    // Save button
                    Button("Save") {
                        saveData()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    
                    // Show saved notes button
                    Button("Show Saved Notes") {
                        showingFSavedNotes = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .sheet(isPresented: $showingFSavedNotes) {
                        FSavedNotes()
                    }
                    
                    // Display saved message
                    Text(fsavedMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding()
            }
            .navigationTitle("Future")
            NavigationLink("Show Saved Notes", destination: FSavedNotes())
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10.0)
            .sheet(isPresented: $showingFSavedNotes) {
                        FSavedNotes()
                    }


        }
    }
    
    // MARK: - Row Function
    
    // Custom row function for creating consistent layout
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
    
    // MARK: - Save Data Function
    
    func saveData() {
        // Save the data model to UserDefaults
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(futureData) {
            UserDefaults.standard.set(encodedData, forKey: "futureData")
            fsavedMessage = "Data Saved!"
        } else {
            fsavedMessage = "Failed to save data."
        }
    }
    
    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "futureData") {
                let decoder = JSONDecoder()
                let futureData = try decoder.decode(FutureData.self, from: encodedData)
                
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
        
    }
    
}

#Preview {
        Future()
}



