//
//  EducatorDashboard.swift
//  EduMatrix Educator
//
//  Created by Divyanshu rai on 18/07/24.
//

import SwiftUI
struct ProfileInfo{
    
    var Ranking:Int
    var Ratings:Float16
    var CourseSales:Int64
    var salesInPercentage:Float16
}
var profileInfo=ProfileInfo(Ranking: 3, Ratings: 4.5, CourseSales: 890000, salesInPercentage: 4.5)
struct EducatorDashboard:View {
    var body: some View {
        VStack(alignment:.leading,spacing: 20){
            Text("Personal Dashboard").font(.title2).bold()
                .padding(.horizontal,7).padding(.top,-10)
            HStack{
                RankingDashboard()
                CourseSellingDashboard()
            }
            .padding(.horizontal, 10)
            .padding(.bottom,-12)
            HStack{
                HStack {
                    RatingsDashboard()
                    GraphDashboard()
                }   .padding(.horizontal,10)
            }
        }
        .padding(.horizontal,10)
        .padding(.bottom,20)
        
    }
}

struct RankingDashboard: View {
    var body: some View {
        VStack {
            Text("Top Ranking").font(.caption).bold()
                .padding(.leading,10)
                .padding(.bottom,10)
            HStack {
                VStack(alignment: .center) {
                    
                    Text("#\(profileInfo.Ranking)").font(.title)
                        .padding(.leading,10)
                        .padding(.bottom,10)
                    Text("Top Educators").font(.caption).bold()
                        .padding(.leading,10)
                        .padding(.bottom,10)
                }
                //                Spacer()
                Image("ranking")
                    .resizable()
                    .frame(width: 80, height: 90)
                    .scaledToFit()
                    .padding(.trailing,0)
            }
        }.frame(width: 170,height:170)
        //        .padding(.all)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
    }
}
struct CourseSellingDashboard: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text("Courses Sales").font(.caption).bold()
                .padding(.leading,40)
                .padding(.bottom,20)
            HStack {
                VStack(alignment: .center) {
                    Text("Rs \(profileInfo.CourseSales)").font(.headline)
                        .padding(.leading,10)
                        .padding(.bottom,10)
                    
                }
                Spacer()
                Image("Icon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .padding(.trailing,10)
            }
            
            HStack() {
                Text("%\(profileInfo.salesInPercentage) ").font(.caption).foregroundStyle(Color.red)
                +
                Text("down from yesterday").font(.caption)
                
                
            }.padding(.leading,10)
                .padding(.bottom,10)
            
        }
        .frame(width: 170,height:170)
        //        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
    }
}

struct RatingsDashboard: View {
    var body: some View {
        VStack{
            Text("Average Rating").font(.caption).bold()
                .padding(.leading,10)
           
                .padding(.top,7)
            
            Image("file")
                .resizable()
                .frame(width: 110, height: 100)
           
            Text("\(profileInfo.Ratings)/5").bold()
                .padding(.leading,2)
                .padding(.bottom,0)
            
            
        }
        .frame(width: 170,height:170).cornerRadius(20)
        .background(Color.white)
        
        .clipShape(Rectangle())
        .cornerRadius(10)
        .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
    }
}

//#Preview {
//   
////    EducatorDashboard()
//    ContentViewHomeTab()
//    
//}
import SwiftUI

// Pie chart segment struct with Identifiable
struct PieChartSegment: Identifiable {
    let id = UUID()
    var value: Double
    var color: Color
}

// Main PieChartView component
struct PieChartView: View {
    var segments: [PieChartSegment]
    var innerRadiusFraction: CGFloat = 0.0
    var thickness: CGFloat = 0.2
    
    private var total: Double {
        segments.reduce(0) { $0 + $1.value }
    }
    
    private func angle(for segment: PieChartSegment) -> Angle {
        let percentage = segment.value / total
        return .degrees(percentage * 360)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(segments) { segment in
                    PieSliceView(startAngle: self.startAngle(for: segment),
                                 endAngle: self.endAngle(for: segment),
                                 color: segment.color,
                                 innerRadiusFraction: innerRadiusFraction,
                                 thickness: thickness)
                }
            }
        }
    }
    
    private func startAngle(for segment: PieChartSegment) -> Angle {
        let index = segments.firstIndex(where: { $0.id == segment.id }) ?? 0
        if index == 0 {
            return .degrees(0)
        }
        let previousSegments = segments[0..<index]
        let previousTotal = previousSegments.reduce(0) { $0 + $1.value }
        return .degrees((previousTotal / total) * 360)
    }
    
    private func endAngle(for segment: PieChartSegment) -> Angle {
        let index = segments.firstIndex(where: { $0.id == segment.id }) ?? 0
        let segmentTotal = segments[0...index].reduce(0) { $0 + $1.value }
        return .degrees((segmentTotal / total) * 360)
    }
}

// Pie slice view component
struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    var innerRadiusFraction: CGFloat
    var thickness: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                path.move(to: center)
                path.addArc(center: center,
                            radius: geometry.size.width / 2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: false)
                
                path.addArc(center: center,
                            radius: geometry.size.width / 2 * innerRadiusFraction,
                            startAngle: endAngle,
                            endAngle: startAngle,
                            clockwise: true)
            }
            .fill(color)
        }
    }
}

// Function to generate PieChartView with sample data
func PieChartFunc() -> some View {
    ZStack {
        //        First Cicle
        PieChartView(segments: [
            PieChartSegment(value: 70,  color:Color(hex: "03045E")), // Value part
            PieChartSegment(value: 30, color: .gray.opacity(0.4)) // Remaining part
        ], innerRadiusFraction: 0.45, thickness: 0.4)
        .frame(width: 105,height: 105)
        PieChartView(segments: [
            PieChartSegment(value: 70, color: .white), // Value part
            PieChartSegment(value: 30, color: .white) // Remaining part
        ], innerRadiusFraction: 0.45, thickness: 0.4)
        .frame(width: 80, height: 80)
        
        //Second Circle
        PieChartView(segments: [
            PieChartSegment(value: 50, color:Color(hex: "0077B6")),
            PieChartSegment(value: 50, color: .gray.opacity(0.4))
        ], innerRadiusFraction: 0.45, thickness: 0.4)
        .frame(width: 65, height: 65)
        .padding(20)
        PieChartView(segments: [
            PieChartSegment(value: 100, color: .white),
            PieChartSegment(value: 0, color: .white)
        ], innerRadiusFraction: 0.5, thickness: 0.4)
        .frame(width: 40, height: 40)
        .padding(30)
        
        //Third Circle
        PieChartView(segments: [
            PieChartSegment(value: 30, color: Color(hex:"00B4D8")),
            PieChartSegment(value: 70, color: .gray.opacity(0.4))
        ], innerRadiusFraction: 0.45, thickness: 0.4)
        .frame(width: 30, height: 30)
        .padding(40)
        PieChartView(segments: [
            PieChartSegment(value: 100, color: .white),
            PieChartSegment(value: 70, color: .white)
        ], innerRadiusFraction: 0.45, thickness: 0.4)
        .frame(width: 02, height: 02)
        .padding(40)
    }
    .frame(width: 80, height: 80)
    .padding() // Add padding around the circles
}

// Function to generate labels
func ChartLabels() -> some View {
    HStack(spacing: 4) {
        HStack {
            Circle().fill(Color(hex: "03045E")).frame(width: 8, height: 10)
            Text("iOS").font(.caption)
        }
        HStack {
            Circle().fill(Color(hex: "0077B6")).frame(width: 8, height: 10)
            Text("Web").font(.caption)
        }
        HStack {
            Circle().fill(Color(hex:"00B4D8")).frame(width: 10, height: 8)
            Text("Swift").font(.caption)
        }
    }
}

// ContentView for preview
struct GraphDashboard: View {
    var body: some View {
        VStack {
            Text("Course Stats").font(.caption).bold()
                .padding(.top,6)
                .padding(.bottom,-5)
            PieChartFunc()
            HStack(spacing: 4) {
                HStack {
                    Circle().fill(Color(hex: "03045E")).frame(width: 8, height: 10)
                    Text("iOS").font(.caption)
                }
                HStack {
                    Circle().fill(Color(hex: "0077B6")).frame(width: 8, height: 10)
                    Text("Web").font(.caption)
                }
                HStack {
                    Circle().fill(Color(hex:"00B4D8")).frame(width: 10, height: 8)
                    Text("Swift").font(.caption)
                }
            }
            
        }.frame(width: 170,height:170)
        
        //        .padding()
        
            .background(Color.white)
        
            .clipShape(Rectangle()).cornerRadius(10)
            .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
        
    }
}

