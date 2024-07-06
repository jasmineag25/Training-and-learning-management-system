//
//  Screen1.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 07/07/24.
//

import SwiftUI

struct OnboardingScreen1: View {
    var body: some View {
            VStack {
                Image("Onboarding1") // Replace with the appropriate image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                Text("Create and Manage")
                    .font(.largeTitle)
                    .bold()
                Text("Courses")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(hex: "25A2FF"))
                Text("Easily design, organize, and update your courses with intuitive tools")
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom,20)
                Text("“Teaching is the one profession that creates all other professions.” - Albert")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
        }
   
}

#Preview {
    OnboardingScreen1()
}

