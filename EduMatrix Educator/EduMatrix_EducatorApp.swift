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
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if Auth.auth().currentUser != nil {
                    ContentView()
                        .environmentObject(viewRouter)
                } else {
                    if hasSeenOnboarding {
                        switch viewRouter.currentPage {
                        case .onboardingView:
                            OnboardingView()
                                .environmentObject(viewRouter)
                                .onAppear {
                                    hasSeenOnboarding = true
                                }
                        case .loginView:
                            LoginView()
                                .environmentObject(viewRouter)
                        case .contentView:
                            ContentView()
                                .environmentObject(viewRouter)
                        case .PersonalDetailsForm:
                            PersonalDetailsForm()
                                .environmentObject(viewRouter)
                        }
                    } else {
                        OnboardingView()
                            .environmentObject(viewRouter)
                            .onAppear {
                                hasSeenOnboarding = true
                            }
                    }
                }
            }
        }
    }
}
