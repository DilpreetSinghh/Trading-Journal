//
//  TradingStyle.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 07/01/24.
//

import SwiftUI
    
    

//                .init(name: "Intraday", imageName: "i.circle.fill", color: .orange),
//                .init(name: "F&O", imageName: "f.circle.fill", color: .blue),
//                .init(name: "Long Term Investment", imageName: "l.circle.fill", color: .brown),
//                .init(name: "Forex Currency", imageName: "f.circle.fill", color: .green),
//                .init(name: "Cryto", imageName: "c.circle.fill", color: .red)]

struct TradingStyle: View {
    var body: some View {
        NavigationStack{
            List{
                Section("Intraday") {
                    NavigationLink {
                        CashDerivative()
                    } label: {
                        Image(systemName: "c.circle.fill")
                        Text("Cash Derivative")
                            
                    }
                    .foregroundStyle(Color.green)
                    
                    NavigationLink {
                        Future()
                    } label: {
                        Image(systemName: "f.circle.fill")
                        Text("Future")
                    }
                    .foregroundStyle(Color.blue)
                    
                    NavigationLink {
                        Option()
                    } label: {
                        Image(systemName: "o.circle.fill")
                        Text("Option")
                    }
                    .foregroundStyle(Color.orange)
                    
                    NavigationLink {
                        CryptoCurrency()
                    } label: {
                        Image(systemName: "x.circle.fill")
                        Text("CryptoCurrency")
                    }
                    .foregroundStyle(Color.red)
                }
                
                Section("Swing or Long Term".capitalized) {
                    NavigationLink {
                        CashDerivative()
                    } label: {
                        Image(systemName: "c.circle.fill")
                        Text("Cash Derivative")
                            
                    }
                    .foregroundStyle(Color.green)
                    
                    NavigationLink {
                        Future()
                    } label: {
                        Image(systemName: "f.circle.fill")
                        Text("Future")
                    }
                    .foregroundStyle(Color.blue)
                    
                    NavigationLink {
                        Option()
                    } label: {
                        Image(systemName: "o.circle.fill")
                        Text("Option")
                    }
                    .foregroundStyle(Color.orange)
                    
                    NavigationLink {
                        CryptoCurrency()
                    } label: {
                        Image(systemName: "x.circle.fill")
                        Text("CryptoCurrency")
                    }
                    .foregroundStyle(Color.red)
                    
                }
            }
            .navigationTitle("Trading Style")
        }
        
    }
}

#Preview {
    TradingStyle()
}
