//
//  CourseCard.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//


//import SwiftUI
//
//struct CourseCard: View {
//    let course: Course
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Image(course.imageName)
//                .resizable()
//                .frame(width: 200, height: 100)
//                .cornerRadius(10)
//            Text(course.title)
//                .font(.headline)
//            Text("By \(course.instructor)")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//            HStack {
//                Text(course.price)
//                Spacer()
//                Text(course.rating)
//                    .foregroundColor(.yellow)
//            }
//            .font(.caption)
//            HStack {
//                Text(course.duration)
//                Spacer()
//                Text(course.lessons)
//                    .foregroundColor(.gray)
//            }
//            .font(.caption)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}
//
//struct CourseCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseCard(course: sampleCourses[0])
//    }
//}
