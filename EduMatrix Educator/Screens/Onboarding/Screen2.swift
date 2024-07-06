//
//  Screen2.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 07/07/24.
//

import SwiftUI

struct OnboardingScreen2: View {
    var body: some View {
        ZStack {
            Color(hex:"#FFFFFF")
                  .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Onboarding2") // Replace with the appropriate image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                Text("Engage with")
                    .font(.largeTitle)
                    .bold()
                Text("Learners")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(hex: "25A2FF"))
                Text("Connect with your students, provide feedback, and foster a collaborative learning environment.")
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Text("“The best teachers are those who show you where to look but don’t tell you what to see.” - Alexandra K. Trenfor")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
}
