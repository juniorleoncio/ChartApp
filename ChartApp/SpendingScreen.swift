//
//  SpendingScreen.swift
//  ChartApp
//
//  Created by Junior Leoncio on 11/09/23.
//

import SwiftUI
import Charts

struct SpendingScreen: View {
    
    @State var selectedTab = "Monthly"
    var tabs = ["Monthly", "Weekly", "Daily"]
    
    var chartData = ["Monthly" : [SavingsDataPoint(month: "May", value: 4000),
                               SavingsDataPoint(month: "Jun", value: 9880),
                               SavingsDataPoint(month: "Jul", value: 6500),
                               SavingsDataPoint(month: "Aug", value: 5500),
                               SavingsDataPoint(month: "Sep", value: 8000),
                               SavingsDataPoint(month: "Oct", value: 4000)],
                     "Weekly" : [SavingsDataPoint(month: "Mon", value: 386),
                      SavingsDataPoint(month: "Tue", value: 451),
                      SavingsDataPoint(month: "Wed", value: 632),
                      SavingsDataPoint(month: "Thu", value: 734),
                      SavingsDataPoint(month: "Fri", value: 800),
                      SavingsDataPoint(month: "Sat", value: 413)],
                     "Daily" : [SavingsDataPoint(month: "8:00", value: 41),
                      SavingsDataPoint(month: "10:00", value: 50),
                      SavingsDataPoint(month: "12:00", value: 65),
                      SavingsDataPoint(month: "14:00", value: 73),
                      SavingsDataPoint(month: "16:00", value: 81),
                      SavingsDataPoint(month: "18:00", value: 55)]]
    var body: some View {
        
        VStack(alignment: .leading) {
            HeaderView()
                .padding(.horizontal)
            
            Text("$9,880.00")
                .font(.title)
                .padding()
            
            ScrollView {
                
                Picker("breakdown", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                ChartView(data: chartData[selectedTab]!)
                    .animation(.easeInOut, value: selectedTab)
                
            }
        }
    }
}


struct SavingsDataPoint: Identifiable {
    let month: String
    let value: Double
    var id = UUID()
}

struct ChartView: View {
    
    var data: [SavingsDataPoint]
    var body: some View {
        
        VStack {
            Chart {
                ForEach(Array(data.enumerated()), id: \.offset) { index, element in
                    BarMark(x: .value("month", element.month), y: .value("price", element.value))
                        .foregroundStyle(index % 2 == 0 ? .teal.opacity(0.3) : .primary)
                        .cornerRadius(5)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic) { value in
                    AxisValueLabel() {
                        if let intValue = value.as(Int.self) {
                            if intValue < 1000 {
                                Text("\(intValue)")
                                    .font(.body)
                            } else {
                                Text("\(intValue/1000)\(intValue == 0 ? "" : "k")")
                                    .font(.body)
                            }
                        }
                    }
                }
            
            }
            .frame(minHeight: 200)
        .padding()
        }
    }
}

struct HeaderView: View {
    
    var body: some View {
        HStack {
            
            Button(action: {
                // Adicione ação relevante aqui
            }) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text("My Spending")
            
            Spacer()
            
            Button(action: {
                // Adicione ação relevante aqui
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingScreen()
    }
}
