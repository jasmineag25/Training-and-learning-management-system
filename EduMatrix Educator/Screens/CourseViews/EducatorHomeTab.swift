import SwiftUI

let userName: String = "Nitin"

//struct ContentViewHomeTab: View {
//    @State private var navigateToRecentUploads = false
//    @State private var courses: [Course] = []
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 20) {
//                ScrollView(.vertical, showsIndicators: false) {
//                    VStack {
//                        HStack {
//                            Text("Transforming Teaching, Inspiring Futures")
//                                .font(.subheadline)
//                                .padding(.leading, 17)
//                                .padding(.top, -10)
//                                .padding(.bottom, 40)
//                            Spacer()
//                            NavigationLink {
//                                ProfileView()
//                            } label: {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                    .padding(.trailing, 10)
//                            }
//                        }
//                        EducatorDashboard()
//                        CourseCardForRecentUploads(courses: $courses)
//                            .padding(.leading, 0)
//                        // Uncomment the following lines if you have CourseCardForTrendingUploads defined
//                        // CourseCardForTrendingUploads(courses: $courses)
//                        //     .padding(.leading, 0)
//                    }
//                }
//                .background(Color(hex: "F2F2F7"))
//            }
//            .navigationTitle("Home")
//            .onAppear() {
//                fetchListOfCourses { coursess in
//                    courses = coursess
//                }
//            }
//        }
//        .background(Color(hex: "F2F2F7"))
//    }
//}

//struct CourseCardForRecentUploads: View {
//    @State private var courses: [Course] = [Course]()
//
//    var body: some View {
//        VStack(alignment: .trailing, spacing: 0) {
//            HStack {
//                Text("Recent Uploads").font(.title2).bold()
//                Spacer()
//                NavigationLink(destination: RecentUploadsFile(courses: courses)) {
//                    Text("See all").font(.title2)
//                }.padding()
//            }.padding(.leading, 20)
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(courses) { course in
//                        NavigationLink(destination: CourseDetailView(courses: course)) {
//                            VStack {
//                                if let url = URL(string: course.imageUrl) {
//                                    AsyncImage(url: url) { image in
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 240, height: 150)
//                                            .clipped()
//                                            .cornerRadius(10)
//                                    } placeholder: {
//                                        Color.gray
//                                            .frame(height: 120)
//                                    }
//                                    .overlay(
//                                        Rectangle().fill(.black).frame(height: 30).cornerRadius(10), alignment: .bottom
//                                    ).overlay(
//                                        Text("\(course.name)").foregroundColor(Color.white).padding(.leading, 10).padding(.bottom, 5), alignment: .bottomLeading
//                                    )
//                                }
//                                HStack {
//                                    Image(systemName: "clock")
//                                        .foregroundColor(.black)
//                                    Text("\(Float16(course.duration)) hour").foregroundColor(.black)
//                                    Spacer()
//                                    Text("Rs \(course.price)").foregroundColor(.black)
//                                }
//                                HStack {
//                                    Image(systemName: "doc.text")
//                                        .foregroundColor(.black)
//                                    Text("\(course.videos.count) lessons").foregroundColor(.black)
//                                    Spacer()
//                                    Text("\(Float16(course.ratings))").foregroundColor(.black)
//                                    Image(systemName: "star.fill")
//                                        .renderingMode(.template)
//                                        .foregroundColor(Color.yellow)
//                                }
//                            }
//                        }
//                    }
//                }.padding(.leading, 20)
//                .padding(.bottom, 20)
//            }
//        }
//    }
//}

struct ContentViewHomeTab: View {
    @State private var navigateToRecentUploads = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Transforming Teaching, Inspiring Futures")
                                .font(.subheadline)
                                .padding(.leading, 17)
                                .padding(.top, -10)
                                .padding(.bottom, 40)
                            Spacer()
                            
                        }
                        EducatorDashboard()
                        CourseCardForRecentUploads() // Use $ to pass binding
                            .padding(.leading, 0)
                    }
                }
                .background(Color(hex: "F2F2F7"))
            }
            .navigationTitle("Home") 
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 10)
                    }
                }
                
            }

            
        }
        .background(Color(hex: "F2F2F7"))
    }
}

struct CourseCardForRecentUploads: View {
    @State private var courses: [Course] = []

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack {
                Text("Recent Uploads").font(.title2).bold()
                Spacer()
                NavigationLink(destination: RecentUploadsFile(courses: courses)) {
                    Text("See all").font(.title2)
                }.padding()
            }.padding(.leading, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(courses) { course in
                        NavigationLink(destination: CourseDetailView(course: course)) {
                            VStack {
                                if let url = URL(string: course.imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 240, height: 150)
                                            .clipped()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        Color.gray
                                            .frame(height: 120)
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
                                        .foregroundColor(.black)
                                    Text("\(course.duration) hour").foregroundColor(.black)
                                    Spacer()
                                    Text("Rs \(course.price)").foregroundColor(.black)
                                }
                                HStack {
                                    Image(systemName: "doc.text")
                                        .foregroundColor(.black)
                                    Text("\(course.videos.count) lessons").foregroundColor(.black)
                                    Spacer()
//                                    Text("\(course.averageRating)").foregroundColor(.black)
                                    Text(String(format: "%.2f", course.averageRating)).foregroundColor(.black)

                                    Image(systemName: "star.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(Color.yellow)
                                }
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
            }
            .onAppear() {
                fetchListOfCourses { coursess in
                    courses = coursess
                }
            }
        }
    }
}
#Preview{
    ContentViewHomeTab()
}
