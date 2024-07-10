import SwiftUI

struct OnboardingScreen4: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationStack{
        ZStack {
            Color(hex: "#FFFFFF")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Onboarding4") // Replace with the appropriate image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                Text("Welcome, to")
                    .font(.largeTitle)
                    .bold()
                
                Text("EduMatrix")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(hex: "25A2FF"))
                
                Text("Empower your students with engaging courses, track their progress, and create a collaborative learning environment. Together, let's inspire and shape the leaders of tomorrow.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                    
                    VStack(spacing: 16) {
                        Button(action: {
                            // Action for "Already an Educator"
                            viewRouter.currentPage = .loginView
                        }) {
                            Text("Already an Educator")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "25A2FF"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                        
                        NavigationLink(destination: PersonalDetailsForm()) {
                            Text("Become an Educator")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: "25A2FF"), lineWidth: 2)
                                )
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen4().environmentObject(ViewRouter())
    }
}
