//
//  Future.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// Define a data model that conforms to Codable
struct FutureData: Identifiable, Codable {
    let id: UUID = UUID()
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

struct CashDerivative: View {
    
    // MARK: - State Variables
    
    // New data model instance
    @State private var cashDerivativeData = CashDerivativeData(
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
    @State private var showingCDSavedNotes = false
    
    // Saved message
    @State private var cdsavedMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // MARK: - Date and Time Section
                    
                    Group {
                        // Date picker for selecting a date
                        row(view: AnyView(DatePicker("Date", selection: $cashDerivativeData.selectedDate, in: ...Date(), displayedComponents: .date)))
                        
                        // Time picker for selecting a time
                        Text("")
                        row(view: AnyView(DatePicker("Time of Trade", selection: $cashDerivativeData.selectedTime, displayedComponents: .hourAndMinute)))
                        
                        // Text field for typing the symbol
                        row(view: AnyView(HStack {
                            Text("Symbol")
                                .foregroundColor(.primary)
                                .frame(width: 100, alignment: .leading) // Adjust width as needed
                            TextField("Type symbol of stock here", text: $cashDerivativeData.CDSymbol)
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
                            TextField("Buy/Sell", text: $cashDerivativeData.CDB_TradingType)
                            TextField("Buy/Sell", text: $cashDerivativeData.CDI_TradingType)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Buy  ")
                            TextField("Buy Price", text: $cashDerivativeData.CDB_BuyPrice)
                            TextField("Buy Price", text: $cashDerivativeData.CDI_BuyPrice)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Sell  ")
                            TextField("Sell Price", text: $cashDerivativeData.CDB_SellPrice)
                            TextField("Sell Price", text: $cashDerivativeData.CDI_SellPrice)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("SL   ")
                            TextField("Stop Loss", text: $cashDerivativeData.CDB_StopLoss)
                            TextField("Stop Loss", text: $cashDerivativeData.CDI_StopLoss)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Qty  ")
                            TextField("Quantity", text: $cashDerivativeData.CDB_Qty)
                            TextField("Quantity", text: $cashDerivativeData.CDI_Qty)
                        }))
                        
                        row(view: AnyView(HStack {
                            Text("Net  ")
                            TextField("Profit/ Loss", text: $cashDerivativeData.CDB_NetProfit)
                            TextField("Profit/ Loss", text: $cashDerivativeData.CDI_NetProfit)
                        }))
                    }
                    
                    // Text editor for notes
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                        TextEditor(text: $cashDerivativeData.notes)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                            .frame(minHeight: 100)
                    }
                    
                    // Save button
                    Button("Save") {
                        cdsaveData()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    
                    // Show saved notes button
                    Button("Show Saved Notes") {
                        showingCDSavedNotes = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .sheet(isPresented: $showingCDSavedNotes) {
                        CDSavedNotes()
                    }
                    
                    // Display saved message
                    Text(cdsavedMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding()
            }
            .navigationTitle(
                Text("Cash Derivative")
            )
            
            NavigationLink("Show Saved Notes", destination: CDSavedNotes())
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8.0)
                .fullScreenCover(isPresented: $showingCDSavedNotes) {
                    CDSavedNotes()
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
    
    func cdsaveData() {
        // Save the data from text fields to the model
        cashDerivativeData.CDSymbol = cashDerivativeData.CDSymbol
        cashDerivativeData.CDB_TradingType = cashDerivativeData.CDB_TradingType
        cashDerivativeData.CDI_TradingType = cashDerivativeData.CDI_TradingType
        cashDerivativeData.CDB_BuyPrice = cashDerivativeData.CDB_BuyPrice
        cashDerivativeData.CDI_BuyPrice = cashDerivativeData.CDI_BuyPrice
        cashDerivativeData.CDB_SellPrice = cashDerivativeData.CDB_SellPrice
        cashDerivativeData.CDI_SellPrice = cashDerivativeData.CDI_SellPrice
        cashDerivativeData.CDB_StopLoss = cashDerivativeData.CDB_StopLoss
        cashDerivativeData.CDI_StopLoss = cashDerivativeData.CDI_StopLoss
        cashDerivativeData.CDB_Qty = cashDerivativeData.CDB_Qty
        cashDerivativeData.CDI_Qty = cashDerivativeData.CDI_Qty
        cashDerivativeData.CDB_NetProfit = cashDerivativeData.CDB_NetProfit
        cashDerivativeData.CDI_NetProfit = cashDerivativeData.CDI_NetProfit
        cashDerivativeData.notes = cashDerivativeData.notes
        
        // Save the date and time
        cashDerivativeData.selectedDate = cashDerivativeData.selectedDate
        cashDerivativeData.selectedTime = cashDerivativeData.selectedTime
        
        // Save the data model to UserDefaults
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(cashDerivativeData)
            UserDefaults.standard.set(encodedData, forKey: "cashDerivativeData")
            cdsavedMessage = "Data Saved!"
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            cdsavedMessage = "Failed to save data."
        }
    }
    
    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cashDerivativeData") {
                let decoder = JSONDecoder()
                let cashDerivativeData = try decoder.decode(CashDerivativeData.self, from: encodedData)
                
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
        
    }
    
}

#Preview {
    CashDerivative()
}
