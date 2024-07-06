//
//  EduMatrix_EducatorApp.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 03/07/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct EduMatrix_EducatorApp: App {
    @StateObject private var courseStore = CourseStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            VStack() {
                if Auth.auth().currentUser == nil {
                    LoginView()
                     .environmentObject(viewRouter)
                } else {
                    ContentView()
                        .environmentObject(viewRouter)
                }
            }
        }
    }
}
