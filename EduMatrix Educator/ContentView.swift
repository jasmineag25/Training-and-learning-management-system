//
//  ContentView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//

import Foundation
import SwiftUI

struct ContentView:View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            CourseView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Courses")
                }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
