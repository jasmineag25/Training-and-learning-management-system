//
//  Screen3.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 07/07/24.
//

import SwiftUI

struct OnboardingScreen3: View {
    var body: some View {
        ZStack{
            Color(hex:"#FFFFFF")
            
            VStack {
                Image("Onboarding3") // Replace with the appropriate image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                Text("Share Resources and")
                    .font(.largeTitle)
                    .bold()
                Text("Materials")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(hex: "25A2FF"))
                Text("Upload and share course materials, resources, and assignments seamlessly.")
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Text("“In learning, you will teach, and in teaching, you will learn.” - Phil Collins")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
}
