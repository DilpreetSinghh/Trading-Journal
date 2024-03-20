//
//  TradingStyle.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 07/01/24.
//

import SwiftUI

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
                        FutureDerivative()
                    } label: {
                        Image(systemName: "f.circle.fill")
                        Text("Future")
                    }
                    .foregroundStyle(Color.blue)
                    
                    NavigationLink {
                        OptionDerivative()
                    } label: {
                        Image(systemName: "o.circle.fill")
                        Text("Option")
                    }
                    .foregroundStyle(Color.orange)
                    
                    NavigationLink {
                        CryptoCurrencyDerivative()
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
                        FutureDerivative()
                    } label: {
                        Image(systemName: "f.circle.fill")
                        Text("Future")
                    }
                    .foregroundStyle(Color.blue)
                    
                    NavigationLink {
                        OptionDerivative()
                    } label: {
                        Image(systemName: "o.circle.fill")
                        Text("Option")
                    }
                    .foregroundStyle(Color.orange)
                    
                    NavigationLink {
                        CryptoCurrencyDerivative()
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
