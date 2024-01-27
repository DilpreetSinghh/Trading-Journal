// CDSavedNotes.swift
import SwiftUI

struct CDSavedNotes: View {
    @State private var savedNotes: String?
    @EnvironmentObject var viewModel: SharedViewModel
    
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter
        }()

        // Time formatter for 24-hour format
        static let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter
        }()

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
            if let encodedData = UserDefaults.standard.data(forKey: "cashDerivativeData") {
                let decoder = JSONDecoder()
                let cashDerivativeData = try decoder.decode(CashDerivativeData.self, from: encodedData)

                // Assuming selectedDate and selectedTime are Date objects
                let dateString = CDSavedNotes.dateFormatter.string(from: cashDerivativeData.selectedDate)
                let timeString = CDSavedNotes.timeFormatter.string(from: cashDerivativeData.selectedTime)

                // Build a string with all the details
                savedNotes = """
                Date: \(dateString)
                Time: \(timeString)
                Symbol: \(cashDerivativeData.CDSymbol)
                CDB Trading Type: \(cashDerivativeData.CDB_TradingType)
                CDI Trading Type: \(cashDerivativeData.CDI_TradingType)
                CDB Buy Price: \(cashDerivativeData.CDB_BuyPrice)
                CDI Buy Price: \(cashDerivativeData.CDI_BuyPrice)
                CDB Sell Price: \(cashDerivativeData.CDB_SellPrice)
                CDI Sell Price: \(cashDerivativeData.CDI_SellPrice)
                CDB Stop Loss: \(cashDerivativeData.CDB_StopLoss)
                CDI Stop Loss: \(cashDerivativeData.CDI_StopLoss)
                CDB Quantity: \(cashDerivativeData.CDB_Qty)
                CDI Quantity: \(cashDerivativeData.CDI_Qty)
                CDB Net Profit: \(cashDerivativeData.CDB_NetProfit)
                CDI Net Profit: \(cashDerivativeData.CDI_NetProfit)
                Notes: \(cashDerivativeData.notes)
                """
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
    

}
