import SwiftUI

struct FDSavedNotes: View {
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
            .navigationTitle("Future Notes")
            .onAppear {
                loadSavedNotes()
            }
        }
    }

    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "futureDerivativeData") {
                let decoder = JSONDecoder()
                let futureDerivativeData = try decoder.decode(FutureDerivativeData.self, from: encodedData)

                // Assuming selectedDate and selectedTime are Date objects
                let dateString = FDSavedNotes.dateFormatter.string(from: futureDerivativeData.selectedDate)
                let timeString = FDSavedNotes.timeFormatter.string(from: futureDerivativeData.selectedTime)

                // Build a string with all the details
                savedNotes = """
                Date: \(dateString)
                Time: \(timeString)
                Symbol: \(futureDerivativeData.FDSymbol)
                FDB Trading Type: \(futureDerivativeData.FDB_TradingType)
                FDI Trading Type: \(futureDerivativeData.FDI_TradingType)
                FDB Buy Price: \(futureDerivativeData.FDB_BuyPrice)
                FDI Buy Price: \(futureDerivativeData.FDI_BuyPrice)
                FDB Sell Price: \(futureDerivativeData.FDB_SellPrice)
                FDI Sell Price: \(futureDerivativeData.FDI_SellPrice)
                FDB Stop Loss: \(futureDerivativeData.FDB_StopLoss)
                FDI Stop Loss: \(futureDerivativeData.FDI_StopLoss)
                FDB Quantity: \(futureDerivativeData.FDB_Qty)
                FDI Quantity: \(futureDerivativeData.FDI_Qty)
                FDB Net Profit: \(futureDerivativeData.FDB_NetProfit)
                FDI Net Profit: \(futureDerivativeData.FDI_NetProfit)
                Notes: \(futureDerivativeData.notes)
                """
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}
