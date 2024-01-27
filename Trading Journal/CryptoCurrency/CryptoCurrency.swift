//
//  CryptoCurrencyDerivative.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

// Define a data model that conforms to Codable
struct CryptoCurrencyDerivativeData: Identifiable, Codable {
    let id: UUID = UUID()
    var selectedDate: Date
    var selectedTime: Date
    var CCSymbol: String
    var CCB_TradingType: String
    var CCI_TradingType: String
    var CCB_BuyPrice: String
    var CCI_BuyPrice: String
    var CCB_SellPrice: String
    var CCI_SellPrice: String
    var CCB_StopLoss: String
    var CCI_StopLoss: String
    var CCB_Qty: String
    var CCI_Qty: String
    var CCB_NetProfit: String
    var CCI_NetProfit: String
    var notes: String
}

struct CryptoCurrencyDerivative: View {
    
    // MARK: - State Variables
    
    @State private var cryptocurrencyDerivativeData = CryptoCurrencyDerivativeData(
        selectedDate: Date(),
        selectedTime: Date(),
        CCSymbol: "",
        CCB_TradingType: "",
        CCI_TradingType: "",
        CCB_BuyPrice: "",
        CCI_BuyPrice: "",
        CCB_SellPrice: "",
        CCI_SellPrice: "",
        CCB_StopLoss: "",
        CCI_StopLoss: "",
        CCB_Qty: "",
        CCI_Qty: "",
        CCB_NetProfit: "",
        CCI_NetProfit: "",
        notes: ""
    )
    
    @State private var showingCCSavedNotes = false
    @State private var ccsavedMessage = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Date and Time Section
                    Group {
                        row(view: AnyView(DatePicker("Date", selection: $cryptocurrencyDerivativeData.selectedDate, in: ...Date(), displayedComponents: .date)))
                        Text("")
                        row(view: AnyView(DatePicker("Time of Trade", selection: $cryptocurrencyDerivativeData.selectedTime, displayedComponents: .hourAndMinute)))
                        row(view: AnyView(HStack {
                            Text("Symbol")
                                .foregroundColor(.primary)
                                .frame(width: 100, alignment: .leading)
                            TextField("Type symbol of cryptocurrency here", text: $cryptocurrencyDerivativeData.CCSymbol)
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
                            TextField("Buy/Sell", text: $cryptocurrencyDerivativeData.CCB_TradingType)
                            TextField("Buy/Sell", text: $cryptocurrencyDerivativeData.CCI_TradingType)
                        }))
                        row(view: AnyView(HStack {
                            Text("Buy  ")
                            TextField("Buy Price", text: $cryptocurrencyDerivativeData.CCB_BuyPrice)
                            TextField("Buy Price", text: $cryptocurrencyDerivativeData.CCI_BuyPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("Sell  ")
                            TextField("Sell Price", text: $cryptocurrencyDerivativeData.CCB_SellPrice)
                            TextField("Sell Price", text: $cryptocurrencyDerivativeData.CCI_SellPrice)
                        }))
                        row(view: AnyView(HStack {
                            Text("SL   ")
                            TextField("Stop Loss", text: $cryptocurrencyDerivativeData.CCB_StopLoss)
                            TextField("Stop Loss", text: $cryptocurrencyDerivativeData.CCI_StopLoss)
                        }))
                        row(view: AnyView(HStack {
                            Text("Qty  ")
                            TextField("Quantity", text: $cryptocurrencyDerivativeData.CCB_Qty)
                            TextField("Quantity", text: $cryptocurrencyDerivativeData.CCI_Qty)
                        }))
                        row(view: AnyView(HStack {
                            Text("Net  ")
                            TextField("Profit/ Loss", text: $cryptocurrencyDerivativeData.CCB_NetProfit)
                            TextField("Profit/ Loss", text: $cryptocurrencyDerivativeData.CCI_NetProfit)
                        }))
                    }
                    
                    // Notes Section
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                        TextEditor(text: $cryptocurrencyDerivativeData.notes)
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
                        ccSaveData()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    
                    Button("Show Saved Notes") {
                        showingCCSavedNotes = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .sheet(isPresented: $showingCCSavedNotes) {
                        CCSavedNotes()
                    }
                    
                    Text(ccsavedMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding()
            }
            .navigationTitle(Text("CryptoCurrency Derivative"))
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
    func ccSaveData() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(cryptocurrencyDerivativeData)
            UserDefaults.standard.set(encodedData, forKey: "cryptocurrencyDerivativeData")
            ccsavedMessage = "Data Saved!"
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            ccsavedMessage = "Failed to save data."
        }
    }
    
    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cryptocurrencyDerivativeData") {
                let decoder = JSONDecoder()
                let cryptocurrencyDerivativeData = try decoder.decode(CryptoCurrencyDerivativeData.self, from: encodedData)
                // Use 'cryptocurrencyDerivativeData' as needed
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

// Preview Section
#if DEBUG
struct CryptoCurrencyDerivative_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyDerivative()
    }
}
#endif
