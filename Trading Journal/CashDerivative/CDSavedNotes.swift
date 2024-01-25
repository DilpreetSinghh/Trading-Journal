//
//  CDSavedNotes.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 20/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct CDSavedNotes: View {

    @State private var savedData: CashDerivativeData?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let data = savedData {
                        // Display saved details
                        Text("Recently Saved Data:")
                            .font(.headline)

                        // Display selected date and time
                        Text("Selected Date: \(data.selectedDate, formatter: dateFormatter)")
                        Text("Selected Time: \(data.selectedTime, formatter: timeFormatter)")

                        // Display trading details
                        Text("Symbol: \(data.CDSymbol)")
                        Text("Buy/Sell (Before): \(data.CDB_TradingType)")
                        Text("Buy/Sell (After): \(data.CDI_TradingType)")
                        Text("Buy Price (Before): \(data.CDB_BuyPrice)")
                        Text("Buy Price (After): \(data.CDI_BuyPrice)")
                        Text("Sell Price (Before): \(data.CDB_SellPrice)")
                        Text("Sell Price (After): \(data.CDI_SellPrice)")
                        Text("Stop Loss (Before): \(data.CDB_StopLoss)")
                        Text("Stop Loss (After): \(data.CDI_StopLoss)")
                        Text("Quantity (Before): \(data.CDB_Qty)")
                        Text("Quantity (After): \(data.CDI_Qty)")
                        Text("Net Profit/Loss (Before): \(data.CDB_NetProfit)")
                        Text("Net Profit/Loss (After): \(data.CDI_NetProfit)")

                        // Display notes
                        Text("Notes:")
                        Text(data.notes)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8.0)
                    } else {
                        Text("No saved data available.")
                    }
                }
                .padding()
            }
            .navigationTitle("Saved Data")
            .onAppear {
                loadSavedData()
            }
        }
    }

    private func loadSavedData() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cashDerivativeData") {
                let decoder = JSONDecoder()
                savedData = try decoder.decode(CashDerivativeData.self, from: encodedData)
            }
        } catch {
            print("Error loading saved data: \(error.localizedDescription)")
        }
    }

    // Date formatter for short date style
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    // Time formatter for 24-hour format
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

#Preview {
    CDSavedNotes()
}
