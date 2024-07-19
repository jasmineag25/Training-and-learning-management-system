//
//  EducatorHomeTab.swift
//  EduMatrix Educator
//
//  Created by Divyanshu rai on 18/07/24.
//



import SwiftUI
let userName:String="Nitin"
struct ContentViewHomeTab: View {
    @State private var navigateToRecentUploads = false
    //    @State private var showProfileImage = true
    let courses = [
        CourseHomeTab(name: "Web Development", description: "This is web Development", keywords: ["Html", "CSS"], price: "1200", ratings: 3.0, duration: 12.5, image: Image("web"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),
        CourseHomeTab(name: "iOS Development", description: "This is iOS Development", keywords: ["Swift", "UI"], price: "2000", ratings: 4.5, duration: 15.0, image: Image("ios"), modules: dummyModules, notes: dummyNotes, assignments: dummyAssignments),]
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading,spacing: 20){
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack {
                        
                        HStack {
                            Text("Transforming Teaching, Inspiring Futures")
                                .font(.subheadline)
                                .padding(.leading, 17)
                                .padding(.top, -10)
                                .padding(.bottom, 40)
                            Spacer()
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
//                                    .padding(.top,-70)
                                
                                    .padding(.trailing,10)
                           }

                           
                        
                        }
//                        Spacer()
                        EducatorDashboard()
                        CourseCardForRecentUploads(courses: courses)
                            .padding(.leading,0)
                        CourseCardForTrendingUploads(courses: courses)
                            .padding(.leading,0)
                    }
                }
                .background(Color(hex: "F2F2F7"))
                
                
            }.navigationTitle("Home")
        }.background(Color(hex: "F2F2F7"))
    }
}


struct ContentForHomeViewRecent: View {
    let courses: [CourseHomeTab]
    @State private var navigateToRecentUploads = false
    
    var body: some View {
        
        EducatorDashboard()
        CourseCardForRecentUploads(courses: courses)
            .padding(.leading,0)
        //            .padding(.top,20)
        CourseCardForTrendingUploads(courses: courses)
            .padding(.leading,0)
            .background(Color(hex: "F2F2F7"))
    }
}


struct CourseCardForRecentUploads:View {
    let courses: [CourseHomeTab]
    var body: some View {
        VStack(alignment:.trailing,spacing: 0){
            HStack {
                Text("Recent Uploads").font(.title2).bold()
                Spacer()
                NavigationLink(destination:RecentUploadsFile()){
                    Text("See all").font(.title2)}.padding()
                
            }.padding(.leading,20)
            ScrollView(.horizontal,showsIndicators: false){
                HStack (spacing: 20){
                    
                    ForEach(courses){ course in
                        NavigationLink(destination: CourseDetailView(course: course)){
                            VStack {
                                
                                course.image .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 240, height: 150)
                                    .cornerRadius(10)
                                    .overlay(
                                        
                                        Rectangle().fill(.black).frame(height: 30).cornerRadius(10),alignment: .bottom
                                        
                                    ).overlay(
                                        Text("\(course.name)") .foregroundColor(Color.white) .padding(.leading,10).padding(.bottom,5),alignment: .bottomLeading
                                        
                                    )  .padding(.leading,1)
                                HStack{
                                    Image(systemName: "clock")
                                        .foregroundColor(.black)
                                    Text("\(Float16(course.duration)) hour") .foregroundColor(.black)
                                    Spacer()
                                    Text("Rs \(course.price)")
                                        .foregroundColor(.black)
                                }
                                HStack{
                                    Image(systemName: "doc.text")
                                        .foregroundColor(.black)
                                    Text("\(course.modules.count) lessons")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("\(Float16(course.ratings))") .foregroundColor(.black)
                                    Image(systemName: "star.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(Color.yellow)
                                }
                            }}
                    }
                }.padding(.leading,20)
                //                    .padding(.top,0)
                
            }
            .padding(.bottom,20)
        }
    }
}
struct CourseCardForTrendingUploads:View {
    let courses: [CourseHomeTab]
    var body: some View {
        VStack(alignment:.trailing,spacing: 0){
            HStack {
                Text("Trending Courses").font(.title2).bold()
                Spacer()
                NavigationLink(destination:TrendingCourseFile()){
                    Text("See all").font(.title2)
                }.padding()
                
            }.padding(.leading,20)
            ScrollView(.horizontal,showsIndicators: false){
                HStack (spacing: 30){
                    
                    ForEach(courses){ course in
                        NavigationLink(destination: CourseDetailView(course: course)){
                            VStack {
                                
                                Image("web") .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 240, height: 150)
                                    .cornerRadius(10)
                                    .overlay(
                                        
                                        Rectangle().fill(.black).frame(height: 30).cornerRadius(10),alignment: .bottom
                                        
                                    ).overlay(
                                        Text("\(course.name)") .foregroundColor(Color.white) .padding(.leading,10).padding(.bottom,5),alignment: .bottomLeading
                                        
                                    )  .padding(.leading,1)
                                HStack{
                                    Image(systemName: "clock")
                                    Text("\(Float16(course.duration)) hour")
                                    Spacer()
                                    Text("Rs \(course.price)")
                                }
                                HStack{
                                    Image(systemName: "doc.text")
                                    Text("\(course.modules.count) lessons")
                                    Spacer()
                                    Text("\(Float16(course.ratings))")
                                    Image(systemName: "star.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(Color.yellow)
                                    
                                }
                            }.foregroundColor(.black)
                        }
                    }
                }
                .padding(.leading,20)}}}}

#Preview {
    ContentViewHomeTab()
    
}
