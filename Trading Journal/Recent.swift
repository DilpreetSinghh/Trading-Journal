//
//  Recent.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 25/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct Recent: View {
    
    @EnvironmentObject var viewModel: SharedViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                CDSavedNotes()
                FDSavedNotes()
                ODSavedNotes()
                CCSavedNotes()
            }
            .navigationTitle("Recent Transactions")
        }
        
    }
}

