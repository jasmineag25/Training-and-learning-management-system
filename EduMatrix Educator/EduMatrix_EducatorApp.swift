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
    //@AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if Auth.auth().currentUser != nil {
                    ContentView()
//                    VideoUploadView1()
//                        .environmentObject(viewRouter)
                        //.preferredColorScheme(isDarkMode ? .dark : .light)
                } else {
                    if hasSeenOnboarding {
                        switch viewRouter.currentPage {
                        case .onboardingView:
                            OnboardingView()
                                .environmentObject(viewRouter)
                               // .preferredColorScheme(isDarkMode ? .dark : .light)
                                .onAppear {
                                    hasSeenOnboarding = true
                                }
                        case .loginView:
                            LoginView()
                               // .preferredColorScheme(isDarkMode ? .dark : .light)
                                .environmentObject(viewRouter)
                        case .contentView:
                            ContentView()
                                .environmentObject(viewRouter)
                                //.preferredColorScheme(isDarkMode ? .dark : .light)
                        case .PersonalDetailsForm:
                            PersonalDetailsForm()
                                .environmentObject(viewRouter)
                        case .onboardingScreen4:
                            OnboardingScreen4()
                                .environmentObject(viewRouter)
                        }
                    } else {
                        OnboardingView()
                            .environmentObject(viewRouter)
                           // .preferredColorScheme(isDarkMode ? .dark : .light)
                            .onAppear {
                                hasSeenOnboarding = true
                            }
                    }
                }
            }
        }
    }
}
