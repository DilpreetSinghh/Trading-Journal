//
//  SharedViewModel.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import Foundation

class SharedViewModel: ObservableObject {
    @Published var cashDerivativeData: CashDerivativeData?
    @Published var error: Error?

    init() {
        loadSavedNotes()
    }

    func loadSavedNotes() {
        do {
            if let encodedData = UserDefaults.standard.data(forKey: "cashDerivativeData") {
                let decoder = JSONDecoder()
                self.cashDerivativeData = try decoder.decode(CashDerivativeData.self, from: encodedData)
            }
        } catch {
            self.error = error
            print("Error loading saved notes: \(error.localizedDescription)")
        }
    }
}

