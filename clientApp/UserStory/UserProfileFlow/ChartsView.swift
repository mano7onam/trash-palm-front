//
//  UserProfileFlow.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import SwiftUI
import SwiftUICharts

struct ChartsView: View {
    
    enum ChartType: String, CaseIterable {
        case invested, earned
    }
    
    enum ChartPeriod: String, CaseIterable {
        case day, week, month, year
    }
    
    @State private var selectedChartType: ChartType = .invested
    @State private var selectedPeriod: ChartPeriod = .day
    
    // Демонстрационные данные
    @State private var investedData: [Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @State private var earnedData: [Double] = [1, 1, 3, 7, 8, 9, 10]
    
    var body: some View {
        VStack {
            Text("Balance")
                .font(.title)
            
            Text("100 tokens / 4 NFT")
            
            Picker("Chose chart type", selection: $selectedChartType) {
                ForEach(ChartType.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Please choose a period", selection: $selectedPeriod) {
                ForEach(ChartPeriod.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            LineView(data: (selectedChartType == .invested ? investedData : earnedData).map{ CGFloat($0) }, title: "Token Price", legend: "Daily price")
                .padding()
            Text("Review caterories")
            HStack {
                Button(action: {
                    print("tokens")
                }) {
                    Text("TOKENS")
                        .frame(width: 80, height: 150)
                        .background(Color.olive)
                        .clipShape(RoundedCorners(tl: 15, tr: 30, bl: 15, br: 15))
                        .foregroundColor(.white)
                }
                Spacer().frame(width: 32)
                Button(action: {
                    print("NFT")
                }) {
                    Text("NFT")
                        .frame(width: 80, height: 150)
                        .background(Color.olive)
                        .clipShape(RoundedCorners(tl: 10, tr: 30, bl: 10, br: 10))
                        .foregroundColor(.white)
                }
            }
            
        }
            .onAppear() {
                updateData()
            }
            .onChange(of: selectedPeriod) { value in
                updateData()
            }
            .onChange(of: selectedChartType) { value in
                updateData()
            }
    }
    
    func updateData() {
        // Здесь должен быть код для обновления данных графика в зависимости от выбранного периода
        // Для демонстрации просто перемешаем данные
        investedData.shuffle()
    }
}


struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
            startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
            startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
            startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        return path
    }
}
