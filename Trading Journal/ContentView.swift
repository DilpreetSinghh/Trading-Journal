//
//  ContentView.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 07/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List{
                Section("Trading Styles"){
                    ForEach(tradingStyle, id: \.name){ style in
                        NavigationLink(value: style){
                            Label(style.name, systemImage: style.imageName)
                                .foregroundColor(style.color)
                        }
                    }
                }
            }.navigationTitle("Journal")
        }
    }
}

#Preview {
    ContentView()
}
