//
//  Trading Style.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 07/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import Foundation
import SwiftUI
struct TradingStyle: Hashable{
    let name: String
    let imageName: String
    let color: Color
}

var tradingStyle: [TradingStyle] = [.init(name: "Intraday", imageName: "i.circle.fill", color: .orange),
                                    .init(name: "F&O", imageName: "f.circle.fill", color: .blue),
                                    .init(name: "Long Term Investment", imageName: "l.circle.fill", color: .brown),
                                    .init(name: "Forex Currency", imageName: "f.circle.fill", color: .green),
                                    .init(name: "Cryto", imageName: "c.circle.fill", color: .red)]
