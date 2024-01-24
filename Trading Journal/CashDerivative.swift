//
//  CashDerivative.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 24/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI

struct CashDerivative: View {
    
    @State var CDSymbol: String = ""
    @State var CDB_TradingType: String = ""
    @State var CDI_TradingType: String = ""
    @State var CDB_BuyPrice: String = ""
    @State var CDI_BuyPrice: String = ""
    @State var CDB_SellPrice: String = ""
    @State var CDI_SellPrice: String = ""
    @State var CDB_StopLoss: String = ""
    @State var CDI_StopLoss: String = ""
    @State var CDB_Qty: String = ""
    @State var CDI_Qty: String = ""
    @State var CDB_NetProfit: String = ""
    @State var CDI_NetProfit: String = ""
    
    let currentDate = Date()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
            
            VStack(spacing: 0){
                HStack{
                    Text("Date")
                        .padding()
                    // Use Date Picker Here
                    TextField("DD/MM/YYY", text: $CDSymbol)
                        .padding()
                        .backgroundStyle(Color.gray.opacity(0.3))
                        .foregroundStyle(Color.accentColor)
                        .cornerRadius(10)
//                    Text(currentDate, style: .date)
//                        .padding()
                }
                HStack{
                    Text("Time")
                    // use time picker
                        .padding()
                    TextField("Time (HH:MM) of purchase", text: $CDSymbol)
                        .padding()
                        .backgroundStyle(Color.gray.opacity(0.3))
                        .foregroundStyle(Color.accentColor)
                        .cornerRadius(10)
//                    Text(currentDate, style: .date)
//                        .padding()
                }
                HStack{
                    Text("Symbol")
                        .padding()
                    TextField("Type symbol of stock here", text: $CDSymbol)
                        .padding()
                        .backgroundStyle(Color.gray.opacity(0.3))
                        .foregroundStyle(Color.accentColor)
                        .cornerRadius(10)
                    
                }
                Spacer()
            }
            
            VStack{
                HStack{
                    Text("List")
                        .padding()
                    Spacer()
                    
                    Text("Before")
                    
                    Spacer()
                        
                    Text("After")
                        .padding()
                
                    
                }
                
                HStack{
                    Text("Trading Type")
                        .padding()
                    Spacer()
                    
                    // use switch here
                    TextField("Buy/Sell", text: $CDB_TradingType)
                    
                    Spacer()
                        
                    TextField("Buy/Sell", text: $CDI_TradingType)
                        .padding()
                }
                HStack{
                    Text("Buy Price")
                        .padding()
                    Spacer()
                    
                    TextField("Buy Price", text: $CDB_BuyPrice)
                    
                    Spacer()
                        
                    TextField("Buy Price", text: $CDI_BuyPrice)
                        .padding()
                }

                HStack{
                    Text("Sell Price")
                        .padding()
                    Spacer()
                    
                    TextField("Sell Price",  text: $CDB_SellPrice)
                    
                    Spacer()
                        
                    TextField("Sell Price", text: $CDI_SellPrice)
                        .padding()
                }
                HStack{
                    Text("Stop Loss")
                        .padding()
                    Spacer()
                    
                    TextField("Stop Loss", text: $CDB_StopLoss)
                    
                    Spacer()
                        
                    TextField("Stop Loss", text: $CDI_StopLoss)
                        .padding()
                }
                HStack{
                    Text("Quantity")
                        .padding()
                    Spacer()
                    
                    TextField("Qty", text: $CDB_Qty)
                    
                    Spacer()
                        
                    TextField("Qty", text: $CDI_Qty)
                        .padding()
                }
                HStack{
                    Text("Net Profit/Loss")
                        .padding()
                    Spacer()
                    
                    TextField("Profit/- Loss", text: $CDB_NetProfit)
                    
                    Spacer()
                        
                    TextField("Profit/- Loss", text: $CDI_NetProfit)
                        .padding()
                }


            }
            
            }
            
            
            
            .navigationTitle("Cash Derivative")
        }
    }
}

#Preview {
    CashDerivative()
}
