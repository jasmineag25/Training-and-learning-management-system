//
//  Recent&TrendingCourses.swift
//  EduMatrix Educator
//
//  Created by Divyanshu rai on 18/07/24.
//

import SwiftUI


#Preview {
//    RecentUploadsFile()
//    TrendingCourseFile()
    ContentViewHomeTab()
}

let dummyModules = [
    Module(title: "Introduction to Swift", videoName: URL(string: "https://www.youtube.com/watch?v=6AjF7XdtMIA&ab_channel=BollywoodSLow")),
    Module(title: "Advanced Swift", videoName: URL(string: "https://example.com/advanced_video.mp4"))

]

let dummyNotes = [
    Note(id: UUID(), title: "Swift Basics", url: Bundle.main.url(forResource: "pdf1", withExtension: "pdf") ?? URL(fileURLWithPath: "sample1"))
]

let dummyAssignments = [
    Assignment(title: "Assignment 1", pdfName: Bundle.main.url(forResource: "assignment1", withExtension: "pdf")),
    Assignment(title: "Assignment 2", pdfName: Bundle.main.url(forResource: "assignment2", withExtension: "pdf"))
]

struct TrendingCourseFile: View {
    var body: some View {
      
        let courses = [
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments)
        ]

      

ScrollView(.vertical, showsIndicators: false) {

ForEach(courses) { course in
NavigationLink(destination: CourseDetailView(course: course)) {
    VStack(spacing: 8) {
        course.image
//                                course.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width:370,height: 230)
            .cornerRadius(10)
            .overlay(
                Rectangle().fill(Color.black.opacity(0.6)).frame(height: 30).cornerRadius(10), alignment: .bottom
            )
            .overlay(
                Text(course.name)
                    .foregroundColor(Color.white)
                    .padding(.leading, 5)
                    .padding(.bottom, 5), alignment: .bottomLeading
            )
            .padding(.top,-10)
        
        HStack {
            Image(systemName: "clock")
            Text("\(Double(course.duration), specifier: "%.1f") hours")
            Spacer()
            Text("Rs \(course.price)")
        }
        .padding(.leading,5)
        .padding(.trailing, 5)
//                                Spacer()
        HStack {
            Image(systemName: "doc.text")
            Text("\(course.modules.count) lessons")
            Spacer()
            Text("\(Double(course.ratings), specifier: "%.1f")")
            Image(systemName: "star.fill")
                .renderingMode(.template)
                .foregroundColor(.yellow)
        }
        .padding(.leading, 6)
        .padding(.trailing, 4)
    }.frame(height:299)

            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
    .padding(.bottom,10)
    .padding(.top,20)
        .foregroundColor(.black)
        
    }
             }
                .padding(.horizontal, 11)
                .navigationTitle("Your Trending Courses")
            }
            .background(Color(hex: "F2F2F7"))
        }
    }

struct RecentUploadsFile: View {
    var body: some View {
      
        let courses = [
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
            CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments)
        ]

       
            
            ScrollView(.vertical, showsIndicators: false) {

ForEach(courses) { course in
NavigationLink(destination: CourseDetailView(course: course)) {
VStack(spacing: 8) {
    course.image

        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width:370,height: 230)
        .cornerRadius(10)
        .overlay(
            Rectangle().fill(Color.black.opacity(0.6)).frame(height: 30).cornerRadius(10), alignment: .bottom
        )
        .overlay(
            Text(course.name)
                .foregroundColor(Color.white)
                .padding(.leading, 5)
                .padding(.bottom, 5), alignment: .bottomLeading
        )
        .padding(.top,-10)
    
    HStack {
        Image(systemName: "clock")
        Text("\(Double(course.duration), specifier: "%.1f") hours")
        Spacer()
        Text("Rs \(course.price)")
    }
    .padding(.leading,5)
    .padding(.trailing, 5)

    HStack {
        Image(systemName: "doc.text")
        Text("\(course.modules.count) lessons")
        Spacer()
        Text("\(Double(course.ratings), specifier: "%.1f")")
        Image(systemName: "star.fill")
            .renderingMode(.template)
            .foregroundColor(.yellow)
    }
    .padding(.leading, 6)
    .padding(.trailing, 4)
}.frame(height:299)

        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
        .padding(.bottom,10)
        .padding(.top,20)
    .foregroundColor(.black)

    }



}
.padding(.horizontal, 11)
.navigationTitle("Your Recent Courses")
}
.background(Color(hex: "F2F2F7"))
}
}

