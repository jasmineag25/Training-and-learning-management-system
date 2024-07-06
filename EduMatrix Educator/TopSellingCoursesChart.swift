//
//  TopSellingCoursesChart.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.

import SwiftUI

struct TopSellingCoursesChart: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Selling Courses")
                .font(.headline).padding(.bottom,10)
            HStack {
                // Pie chart view can be implemented here
                // For simplicity, using a placeholder circle
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(Color.blue, lineWidth: 15)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text("Rs.200")
                            .font(.headline)
                    ).padding(.leading,30)
                VStack(alignment: .leading) {
                    ChartLegendItem(color: .blue, text: "App Development").font(.headline)
                    ChartLegendItem(color: .green, text: "Web Development").font(.headline)
                    ChartLegendItem(color: .orange, text: "Ui/Ux").font(.headline)
                }
                .padding(.leading,60)
                
            }
            
        }
        .padding(.top,-20)
    }
}

struct ChartLegendItem: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 13, height: 13)
            Text(text)
                .font(.subheadline)
        }
    }
}

struct TopSellingCoursesChart_Previews: PreviewProvider {
    static var previews: some View {
        TopSellingCoursesChart()
    }
}
