import SwiftUI

struct CCSavedNotes: View {
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
            .navigationTitle("Crypto Notes")
            .onAppear {
                loadSavedNotes()
            }
        }
    }

    private func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cryptocurrencyDerivativeData") {
                let decoder = JSONDecoder()
                let cryptocurrencyDerivativeData = try decoder.decode(CryptoCurrencyDerivativeData.self, from: encodedData)

                // Assuming selectedDate and selectedTime are Date objects
                let dateString = CCSavedNotes.dateFormatter.string(from: cryptocurrencyDerivativeData.selectedDate)
                let timeString = CCSavedNotes.timeFormatter.string(from: cryptocurrencyDerivativeData.selectedTime)

                // Build a string with all the details
                savedNotes = """
                Date: \(dateString)
                Time: \(timeString)
                Symbol: \(cryptocurrencyDerivativeData.CCSymbol)
                CCB Trading Type: \(cryptocurrencyDerivativeData.CCB_TradingType)
                CCI Trading Type: \(cryptocurrencyDerivativeData.CCI_TradingType)
                CCB Buy Price: \(cryptocurrencyDerivativeData.CCB_BuyPrice)
                CCI Buy Price: \(cryptocurrencyDerivativeData.CCI_BuyPrice)
                CCB Sell Price: \(cryptocurrencyDerivativeData.CCB_SellPrice)
                CCI Sell Price: \(cryptocurrencyDerivativeData.CCI_SellPrice)
                CCB Stop Loss: \(cryptocurrencyDerivativeData.CCB_StopLoss)
                CCI Stop Loss: \(cryptocurrencyDerivativeData.CCI_StopLoss)
                CCB Quantity: \(cryptocurrencyDerivativeData.CCB_Qty)
                CCI Quantity: \(cryptocurrencyDerivativeData.CCI_Qty)
                CCB Net Profit: \(cryptocurrencyDerivativeData.CCB_NetProfit)
                CCI Net Profit: \(cryptocurrencyDerivativeData.CCI_NetProfit)
                Notes: \(cryptocurrencyDerivativeData.notes)
                """
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}
