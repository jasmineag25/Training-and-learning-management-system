//
//  HomeView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
                   Text("Welcome to Your App!")
                       .font(.title)
                       .padding()
                   
                   // Add more content as needed
                   
                   Button(action: {
                       // Action for sign out
                       signOut()
                   }) {
                       Text("Sign Out")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: 220, height: 50)
                           .background(Color.red) // Use any color you prefer
                           .cornerRadius(10.0)
                           .padding(.top, 20)
                   }
                   
                   Spacer()
               }
               .padding()
           }
           
           func signOut() {
               do {
                   try Auth.auth().signOut()
                   // Navigate back to login or initial screen
                   viewRouter.currentPage = .loginView// Adjust as per your ViewRouter setup
               } catch let signOutError as NSError {
                   print("Error signing out: \(signOutError.localizedDescription)")
               }
//           NavigationView {
//               ScrollView {
//                   VStack(alignment: .leading) {
//                       HStack {
//                           Text("Hello,")
//                               .font(.largeTitle)
//                               .bold()
//                           Spacer()
//                           Button(action: {
//                               // Action for profile button
//                           }) {
//                               Image(systemName: "person.circle.fill")
//                                   .resizable()
//                                   .frame(width: 40, height: 40)
//                                   .foregroundColor(.blue)
//                           }
//                       }
//                       
//                       Text("Inspire, Educate, Transform")
//                           .font(.title3)
//                           .foregroundColor(.gray)
//                       
//                       SearchBar()
//                       
//                       TopSellingCoursesChart()
//                           .frame(height: 120)
//                           .padding(.vertical)
//                       
//                       CourseSection(title: "Recent Uploads", courses: sampleCourses)
//                       
//                       CourseSection(title: "Trending Courses", courses: sampleCourses)
//                   }
//                   .padding()
//               }
//               .navigationBarHidden(true)
//           }
       }
}

#Preview {
    HomeView()
}
