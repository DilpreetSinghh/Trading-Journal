import SwiftUI

struct CDSavedNotes: View {

    @State private var cdsavedNotes: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let notes = cdsavedNotes {
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
                // Decode the saved data
                let decoder = JSONDecoder()
                let cashDerivativeData = try decoder.decode(CashDerivativeData.self, from: encodedData)

                // Access the notes property from the decoded data
                cdsavedNotes = cashDerivativeData.notes
            }
        } catch {
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

struct SavedNotesView_Previews: PreviewProvider {
    static var previews: some View {
        CDSavedNotes()
    }
}
