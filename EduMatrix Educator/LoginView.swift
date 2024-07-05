import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isSignIn: Bool = false
    
    init() {
        self.navigationBarBackButtonHidden()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Illustration
                Image("illustration") // Replace with your actual image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding(.top, 50)
                
                Text("Log in")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                // Email field
                TextField("Email address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .overlay(
                        HStack {
                            Spacer()
                            if !email.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        }
                    )
                    .padding(.top, 20)
                
                // Password field
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.top, 10)
                
                // Forgot password
                HStack {
                                    Spacer()
                                    NavigationLink(destination: ForgotPasswordView()) {
                                        Text("Forgot password?")
                                            .font(.system(size: 14))
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.top, 5)
                
                // Login button
                Button(action: {
                    // Action for login
                    checkLoginCredentials(email: email, password: password, expectedRole: "educator")
                    
                    isSignIn=true
                    
                }) {
                   
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                        .padding(.top, 20)

                }
               NavigationLink(destination: ContentView(), isActive: $isSignIn) {
                    EmptyView()
                }
          
                
                // Or Login with
//                Text("Or Login with")
//                    .padding(.top, 30)
//                
//                HStack(spacing: 20) {
//                    Button(action: {
//                        // Action for Facebook login
//                    }) {
//                        Image(systemName: "f.square.fill")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.blue)
//                    }
//                    Button(action: {
//                        // Action for Google login
//                    }) {
//                        Image(systemName: "g.circle.fill")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.red)
//                    }
//                    Button(action: {
//                        // Action for Apple login
//                    }) {
//                        Image(systemName: "applelogo")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.black)
//                    }
//                }
//                .padding(.top, 10)
                
                // Sign up link
                HStack {
                    Text("Don’t have an account?")
                    NavigationLink(destination: PersonalDetailsForm()) {
                        Text("Sign up")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .navigationBarHidden(true)
        }
    }
    
    func checkLoginCredentials(email: String, password: String, expectedRole: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                guard let userID = authResult?.user.uid else { return }
                let db = Firestore.firestore()
                let docRef = db.collection("users").document(userID)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        let role = data?["role"] as? String
                        if role == expectedRole {
//                            navigateToHome.toggle()
                            print("User signed in successfully with role: \(role ?? "")")
                        } else {
                            print("User role mismatch. Expected: \(expectedRole), Found: \(role ?? "")")
                            // Sign out the user if the role does not match
                            do {
                                try Auth.auth().signOut()
                            } catch let signOutError as NSError {
                                print("Error signing out: \(signOutError)")
                            }
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
