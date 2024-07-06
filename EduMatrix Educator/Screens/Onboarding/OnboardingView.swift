//
//  OnboardingView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 07/07/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                OnboardingScreen1()
                    .tag(0)
                OnboardingScreen2()
                    .tag(1)
                OnboardingScreen3()
                    .tag(2)
                OnboardingScreen4()
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                Spacer()
                if selectedTab < 3 {
                    HStack {
                        HStack {
                            Spacer(minLength: 160)
                            HStack {
                                ForEach(0..<4) { index in
                                    Circle()
                                        .fill(index <= selectedTab ? Color(hex: "#25A2FF") : Color.gray)
                                        .frame(width: 15, height: 15)
                                }
                                .padding(.top, 10)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                if selectedTab < 3 {
                                    selectedTab += 1
                                }
                            }) {
                                Image(systemName: "arrow.right")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color(hex: "#25A2FF"))
                                    .clipShape(Circle())
                                    .padding()
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
