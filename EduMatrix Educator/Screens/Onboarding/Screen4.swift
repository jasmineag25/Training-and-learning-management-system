//
//  Screen4.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 07/07/24.
//

import SwiftUI

struct OnboardingScreen4: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            Color(hex:"#FFFFFF")
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
                    .padding()
                Spacer()
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
                Button(action: {
                    // Action for "Become an Educator"
                    viewRouter.currentPage = .PersonalDetailsForm
                }) {
                    Text("Become an Educator")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "25A2FF"), lineWidth: 2)
                        )
                        .padding(.horizontal)
                }
                Spacer()
            }
            .padding()
        }
    }
}
