////
////  CourseView.swift
////  EduMatrix Educator
////
////  Created by Shahiyan Khan on 05/07/24.
/*
 import SwiftUI
 
 struct CourseView: View {
 @State private var isShowingCourseDetailView = false
 @EnvironmentObject var courseStore: CourseStore
 
 @State private var courses: [Course] = []
 
 var body: some View {
 NavigationStack {
 VStack {
 HStack {
 Text("My Courses")
 .font(.largeTitle)
 .fontWeight(.bold)
 .padding(.leading, 20)
 Spacer()
 Button(action: {
 isShowingCourseDetailView.toggle()
 }) {
 Image(systemName: "plus")
 .font(.title)
 .padding(.trailing, 20)
 }
 NavigationLink(destination: CourseDetailsView(courses: $courses), isActive: $isShowingCourseDetailView) {
 EmptyView()
 }
 }
 List(courses) { course in
 CourseRow(course: course)
 }
 .listStyle(PlainListStyle())
 }
 }
 }
 }
 
 struct CourseRow: View {
 var course: Course
 
 var body: some View {
 HStack {
 VStack(alignment: .leading) {
 Text(course.name)
 .font(.headline)
 Text(course.description)
 .font(.subheadline)
 .foregroundColor(.gray)
 HStack {
 ForEach(0..<5) { index in
 Image(systemName: index < course.keywords.count ? "star.fill" : "star")
 .foregroundColor(.orange)
 }
 }
 }
 Spacer()
 Text(course.price)
 .font(.headline)
 }
 .padding(.vertical, 10)
 }
 }
 
 #Preview {
 CourseView()
 }
 
/*
import SwiftUI

struct CourseView: View {
    @State private var isShowingCourseDetailView = false
    @EnvironmentObject var courseStore: CourseStore
    
    //    @State private var courses: [Course] = []
    @State private var courses: [CourseHomeTab] = [
        CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
        CourseHomeTab(name: "iOS Development", description: "Learn to build apps for iOS", keywords: ["Swift", "Xcode"], price: "1500", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments)
    ]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Courses")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        isShowingCourseDetailView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding(.trailing, 20)
                    }
//                    NavigationLink(destination: CourseDetailsView(courses: $courses), isActive: $isShowingCourseDetailView) {
//                    EmptyView()
//                    }
                }
                ForEach(courses) { course in
                    NavigationLink(destination: CourseDetailView(course: course)) {
                        CourseRow(course: course)
                    }
                    
//                    .listStyle(PlainListStyle())
                }
            }
        }
    }
    
    struct CourseRow: View {
        var course: CourseHomeTab
        
        var body: some View {
            VStack(spacing: 9) {
                course.image
        //                                course.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:366,height: 230)
                    .cornerRadius(10)
                    .overlay(
                        Rectangle().fill(Color.black.opacity(0.6)).frame(height: 30).cornerRadius(10), alignment: .bottom
                    )
                    .overlay(
                        Text(course.name)
                            .foregroundColor(Color.white)
                            .padding(.leading, 10)
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
            }.frame(width:360,height:296)

                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
            .padding(.bottom,10)
            .padding(.top,10)
                .foregroundColor(.black)
            .padding(.vertical, 0)
        }
    }
}
#Preview {
    CourseView()
}
*/
struct CourseView: View {
    var courses : [Course]=[]

    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false) {

ForEach(courses) { course in
    NavigationLink(destination: CourseDetailView(course: course)) {
        VStack(spacing: 8) {
            
            if let url = URL(string: course.imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 370, height: 250)
                        .cornerRadius(10)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(width:240,height: 150).cornerRadius(10)
                }
                .overlay(
                    Rectangle().fill(.black).frame(height: 30).cornerRadius(10),
                    alignment: .bottom
                ).overlay(
                    Text("\(course.name)").foregroundColor(Color.white).padding(.leading, 10).padding(.bottom, 5),
                    alignment: .bottomLeading
                )
            }
            HStack {
                Image(systemName: "clock")
                Text("\(course.duration) hours")
                Spacer()
                Text("Rs \(course.price)")
            }
            .padding(.leading,5)
            .padding(.trailing, 5)
            
            HStack {
                Image(systemName: "doc.text")
                Text("\(course.videos.count) lessons")
                Spacer()
                Text(String(format: "%.2f", course.averageRating))
                Image(systemName: "star.fill")
                    .renderingMode(.template)
                    .foregroundColor(.yellow)
            }
            .padding(.leading, 6)
            .padding(.trailing, 4)
        }.frame(height:319)
        
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
*/
import SwiftUI

struct CourseView: View {
    @State private var isShowingCourseDetailView = false
    @EnvironmentObject var courseStore: CourseStore

    @State private var courses: [Course] = []

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Courses")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        isShowingCourseDetailView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding(.trailing, 20)
                    }
                    NavigationLink(destination: CourseDetailsView(courses: $courses), isActive: $isShowingCourseDetailView) {
                        EmptyView()
                    }
                }
                .padding(.top, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(courses) { course in
                        NavigationLink(destination: CourseDetailView(course: course)) {
                            VStack(spacing: 8) {
                                if let url = URL(string: course.imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 370, height: 250)
                                            .cornerRadius(10)
                                            .clipped()
                                    } placeholder: {
                                        Color.gray
                                            .frame(width: 240, height: 150)
                                            .cornerRadius(10)
                                    }
                                    .overlay(
                                        Rectangle()
                                            .fill(.black)
                                            .frame(height: 30)
                                            .cornerRadius(10),
                                        alignment: .bottom
                                    ).overlay(
                                        Text(course.name)
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                            .padding(.bottom, 5),
                                        alignment: .bottomLeading
                                    )
                                }
                                HStack {
                                    Image(systemName: "clock")
                                    Text("\(course.duration) hours")
                                    Spacer()
                                    Text("Rs \(course.price)")
                                }
                                .padding(.leading, 5)
                                .padding(.trailing, 5)

                                HStack {
                                    Image(systemName: "doc.text")
                                    Text("\(course.videos.count) lessons")
                                    Spacer()
                                    Text(String(format: "%.2f", course.averageRating))
                                    Image(systemName: "star.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.yellow)
                                }
                                .padding(.leading, 6)
                                .padding(.trailing, 4)
                            }
                            .frame(height: 319)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray, radius: 1, x: 0, y: 1)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                            .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 11)
                   
                }
                .background(Color(hex: "F2F2F7"))
            }
        }
        .onAppear {
            fetchListOfCourses(){coursesList in
                courses = coursesList
            }
        }
    }
}

struct CourseRow: View {
    var course: Course

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.headline)
                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < course.keywords.count ? "star.fill" : "star")
                            .foregroundColor(.orange)
                    }
                }
            }
            Spacer()
            Text(course.price)
                .font(.headline)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    CourseView()
}
