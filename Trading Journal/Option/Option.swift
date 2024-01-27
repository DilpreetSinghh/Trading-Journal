//
//  OptionDerivative.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// Define a data model that conforms to Codable
struct OptionDerivativeData: Identifiable, Codable {
    let id: UUID = UUID()
    var selectedDate: Date
    var selectedTime: Date
    var ODSymbol: String
    var ODB_TradingType: String
    var ODI_TradingType: String
    var ODB_BuyPrice: String
    var ODI_BuyPrice: String
    var ODB_SellPrice: String
    var ODI_SellPrice: String
    var ODB_StopLoss: String
    var ODI_StopLoss: String
    var ODB_Qty: String
    var ODI_Qty: String
    var ODB_NetProfit: String
    var ODI_NetProfit: String
    var notes: String
}

struct OptionDerivative: View {
    
    // MARK: - State Variables
    
    @State private var optionDerivativeData = OptionDerivativeData(
        selectedDate: Date(),
        selectedTime: Date(),
        ODSymbol: "",
        ODB_TradingType: "",
        ODI_TradingType: "",
        ODB_BuyPrice: "",
        ODI_BuyPrice: "",
        ODB_SellPrice: "",
        ODI_SellPrice: "",
        ODB_StopLoss: "",
        ODI_StopLoss: "",
        ODB_Qty: "",
        ODI_Qty: "",
        ODB_NetProfit: "",
        ODI_NetProfit: "",
        notes: ""
    )
    
    @State private var showingODSavedNotes = false
    @State private var odsavedMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Date and Time Section
                    Group {
                        row(view: AnyView(DatePicker("Date", selection: $optionDerivativeData.selectedDate, in: ...Date(), displayedComponents: .date)))
                        Text("")
                        row(view: AnyView(DatePicker("Time of Trade", selection: $optionDerivativeData.selectedTime, displayedComponents: .hourAndMinute)))
                        row(view: AnyView(HStack {
                            Text("Symbol")
                                .foregroundColor(.primary)
                                .frame(width: 100, alignment: .leading)
                            TextField("Type symbol of stock here", text: $optionDerivativeData.ODSymbol)
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
                            TextField("Buy/Sell", text: $optionDerivativeData.ODB_TradingType)
                            TextField("Buy/Sell", text: $optionDerivativeData.ODI_TradingType)
                        }))
                        row(view: AnyView(HStack {
                            Text("Buy  ")
                            TextField("Buy Price", text: $optionDerivativeData.ODB_BuyPrice)
                            TextField("Buy Price", text: $optionDerivativeData.ODI_BuyPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("Sell  ")
                            TextField("Sell Price", text: $optionDerivativeData.ODB_SellPrice)
                            TextField("Sell Price", text: $optionDerivativeData.ODI_SellPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("SL   ")
                            TextField("Stop Loss", text: $optionDerivativeData.ODB_StopLoss)
                            TextField("Stop Loss", text: $optionDerivativeData.ODI_StopLoss)
                        }))
                        row(view: AnyView(HStack {
                            Text("Qty  ")
                            TextField("Quantity", text: $optionDerivativeData.ODB_Qty)
                            TextField("Quantity", text: $optionDerivativeData.ODI_Qty)
                        }))
                        row(view: AnyView(HStack {
                            Text("Net  ")
                            TextField("Profit/ Loss", text: $optionDerivativeData.ODB_NetProfit)
                            TextField("Profit/ Loss", text: $optionDerivativeData.ODI_NetProfit)
                        }))
                    }
                    
                    // Notes Section
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                        TextEditor(text: $optionDerivativeData.notes)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                            .frame(minHeight: 100)
                    }
                    
                    // Save and Show Saved Notes Buttons
                    Button("Save") {
                        odSaveData()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    
                    Button("Show Saved Notes") {
                        showingODSavedNotes = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .sheet(isPresented: $showingODSavedNotes) {
                        ODSavedNotes()
                    }
                    
                    Text(odsavedMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding()
            }
            .navigationTitle(Text("Option Derivative"))
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
    func odSaveData() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(optionDerivativeData)
            UserDefaults.standard.set(encodedData, forKey: "optionDerivativeData")
            odsavedMessage = "Data Saved!"
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            odsavedMessage = "Failed to save data."
        }
    }
    
    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "optionDerivativeData") {
                let decoder = JSONDecoder()
                let optionDerivativeData = try decoder.decode(OptionDerivativeData.self, from: encodedData)
                // Use 'optionDerivativeData' as needed
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

// Preview Section
#if DEBUG
struct OptionDerivative_Previews: PreviewProvider {
    static var previews: some View {
        OptionDerivative()
    }
}
#endif
