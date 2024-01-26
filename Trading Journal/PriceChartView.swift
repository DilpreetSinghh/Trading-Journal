//
//  PriceChartView.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct TradeData {
    var price: Double
    var date: Date
}

// Example of a simple line chart view
struct PriceChartView: View {
    var tradeData: [TradeData] // Assume TradeData is a model containing price and date

    var body: some View {
        // Convert TradeData to an array of LineChartDataPoint
        let dataPoints: [LineChartDataPoint] = tradeData.map { LineChartDataPoint(value: $0.price, xAxisLabel: formatter.string(from: $0.date), description: formatter.string(from: $0.date)) }
        
        // Create a LineDataSet
        let dataSet = LineDataSet(dataPoints: dataPoints,
                                  style: LineStyle(lineColour: ColourStyle(colour: .blue), lineType: .curvedLine)) // Adjust lineColor to use Color
        
        // Create a LineChartData object with the LineDataSet
        let lineChartData = LineChartData(dataSets: dataSet)
        
        // Create the LineChart
        LineChart(chartData: lineChartData)
            .touchOverlay(chartData: lineChartData, specifier: "%.2f")
            .xAxisGrid(chartData: lineChartData)
            .yAxisGrid(chartData: lineChartData)
            .xAxisLabels(chartData: lineChartData)
            .yAxisLabels(chartData: lineChartData, specifier: "%.2f")
            .infoBox(chartData: lineChartData)
            .headerBox(chartData: lineChartData)
            .legends(chartData: lineChartData, columns: [GridItem(.flexible()), GridItem(.flexible())])
            .id(lineChartData.id)
            .frame(minWidth: 150, maxWidth: 900, minHeight: 150, maxHeight: 400)
            .padding(.horizontal)
    }
}

// Helper to format the date
let formatter: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd-MM-yyyy"
    return fmt
}()

