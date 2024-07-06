//
//  ForgotPasswordView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//

//

import Foundation
import SwiftUI

struct ForgotPasswordView: View {
    @State private var identifier: String = ""
    @State private var showConfirmation: Bool = false
    @State private var showError: Bool = false
    @State private var isRedirectingToOTPView :Bool=false
    @Environment(\.presentationMode) var presentationMode
   // @StateObject var userViewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Image("Group 513886") // Use a system image or replace with your own image name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200) // Adjust the size as needed
                                    .padding(.top, 60) //
                

                VStack(spacing: 8) {
                    Text("Forgot password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading,0)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,10)

                    Text("Don’t worry! It happens. Please enter the email associated with your account.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom,10)
                        .padding(.top,10)
                }
                .padding(.bottom, 40)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email address")
                        .font(.headline)

                    TextField("Enter your email address", text: $identifier)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                

                Button(action: {
                    if identifier.isEmpty {
                        showError = true
                    } else {
                        // Implement the action to handle forgot password here
                        showConfirmation = true
                    }
                }) {
                    Text("Send code")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                
                Spacer()
                Spacer()
                HStack {
                    Text("Remember password?")
                        .font(.body)

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log in")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }

                Spacer()
            }
            .padding()
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please enter your email address."),
                    dismissButton: .default(Text("OK")) {
                        showError = false // Reset the error state
                    }
                )
            }
            .alert(isPresented: $showConfirmation) {
                            Alert(
                                title: Text("Password Reset"),
                                message: Text("An OTP has been sent to your mail."),
                                dismissButton: .default(Text("OK")) {
                                    showConfirmation = false // Reset the confirmation state
                                    isRedirectingToOTPView = true // Activate navigation to OTPView
                                }
                            )
                        }
                        .background(
                            NavigationLink(destination: OTPView(), isActive: $isRedirectingToOTPView) {
                                EmptyView()
                            }
                            .hidden()
                        )
                    }
                    .navigationBarHidden(true)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
