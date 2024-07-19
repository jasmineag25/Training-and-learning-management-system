import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    //@AppStorage("isDarkMode") private var isDarkMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isSignIn: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPasswordFocused = false
    @State private var isPopoverVisible = false // Track popover visibility
    @State private var showPasswordDropdown = false

    var body: some View {
        NavigationStack {
            VStack {
                // Illustration
                Image("login") // Replace with your actual image name
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .padding(.top, 30)
                   
                Text("Log in")
                    .font(.largeTitle)
                    .bold()

                // Email field
                VStack(alignment: .leading) {
                    TextField("Email address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .overlay(
                            HStack {
                                Spacer()
                                if email.isEmpty {
                                    Image(systemName: "")
                                        .padding()
                                } else if isValidEmail(email) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .padding()
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                            }
                        )
                        .padding(.top, 20)
                    if !isValidEmail(email) && !email.isEmpty {
                        Text("Please enter a valid email address.")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }

                // Password field with dropdown suggestion
                VStack(alignment: .leading) {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .onChange(of: password) { _ in
                                    isPasswordFocused = true
                                    isPopoverVisible = true
                                }
//                                .overlay(
//                                    GeometryReader { geometry in
//                                        VStack {
//                                            if showPasswordDropdown {
//                                                Spacer(minLength: 50)
//                                                Button(action: {
//                                                    password = generateRandomPassword()
//                                                    showPasswordDropdown = false
//                                                }) {
//                                                    Text("Suggested Password: \(generateRandomPassword())")
//                                                        .padding()
//                                                        .background(Color(.secondarySystemBackground))
//                                                        .cornerRadius(5.0)
//                                                }
//                                                .padding(.top, 5)
//                                                .transition(.move(edge: .bottom))
//                                                .animation(.easeInOut)
//                                            }
//                                        }
//                                        .frame(width: geometry.size.width, alignment: .leading)
//                                    }
//                                )
                        } else {
                            SecureField("Enter 8 Digit Password", text: $password)
                                .onChange(of: password) { _ in
                                    isPasswordFocused = true
                                    isPopoverVisible = true
                                }
//                                .overlay(
//                                    GeometryReader { geometry in
//                                        VStack {
//                                            if showPasswordDropdown {
//                                                Spacer(minLength: 50)
//                                                Button(action: {
//                                                    password = generateRandomPassword()
//                                                    showPasswordDropdown = false
//                                                }) {
//                                                    Text("Suggested Password: \(generateRandomPassword())")
//                                                        .padding()
//                                                        .background(Color(.secondarySystemBackground))
//                                                        .cornerRadius(5.0)
//                                                }
//                                                .padding(.top, 5)
//                                                .transition(.move(edge: .bottom))
//                                                .animation(.easeInOut)
//                                            }
//                                        }
//                                        .frame(width: geometry.size.width, alignment: .leading)
//                                    }
//                                )
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
                    .onTapGesture {
                        showPasswordDropdown = true
                    }
                }

                // Forgot password
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 5)

                // Login button
                Button(action: {
                    checkLoginCredentials(email: email, password: password)
                }) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(isFormValid() ? Color.blue : Color.gray)
                        .cornerRadius(10.0)
                        .padding(.top, 20)
                }
                .disabled(!isFormValid())
                Spacer(minLength: 50)

                // Sign up link
                NavigationLink(destination: PersonalDetailsForm()) {
                    Text("Become an Educator?")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 30)
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onTapGesture {
                isPopoverVisible = false // Hide popover when tapped outside
                showPasswordDropdown = false // Hide password dropdown when tapped outside
            }
        }
//        .overlay(
//            Group {
//                if isPasswordFocused && !password.isEmpty && isPopoverVisible {
//                    PasswordCriteriaPopover(password: $password)
//                        .padding(.trailing, 140)
//                        .padding(.leading, 20)
//                        .padding(.top, 12)
//                        .transition(.move(edge: .bottom))
//                        .zIndex(1) // Ensure popover is above other views
//                        .background(
//                            Color.black.opacity(0.001)
//                                .onTapGesture {
//                                    isPopoverVisible = false
//                                }
//                        )
//                        .offset(y: 200) // Adjust the offset to position the popover below the password field
//                }
//            }
//        )
    }
    
    private func validateCredentials(email: String, password: String) -> Bool {
        if email.isEmpty || !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return false
        }

        if password.isEmpty {
            alertMessage = "Please enter a password."
            showAlert = true
            return false
        }

        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let allowedDomains = [
            "gmail.com", "yahoo.com", "hotmail.com", "outlook.com", "icloud.com",
            "aol.com", "mail.com", "zoho.com", "protonmail.com", "gmx.com"
        ]
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@(" + allowedDomains.joined(separator: "|") + ")$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func isFormValid() -> Bool {
        return isValidEmail(email) && !password.isEmpty && password.count >= 8
    }

    private func checkLoginCredentials(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            } else {
                let db = Firestore.firestore()
                let docRef = db.collection("educators").document(email)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        isSignIn = true
                        viewRouter.currentPage = .contentView
                    } else {
                        alertMessage = "User role mismatch. Expected: Educator"
                        showAlert = true
                        do {
                            try Auth.auth().signOut()
                        } catch let signOutError as NSError {
                            alertMessage = "Error signing out: \(signOutError.localizedDescription)"
                            showAlert = true
                        }
                    }
                }
            }
        }
    }

    private func generateRandomPassword(length: Int = 8) -> String {
        // Character sets for different criteria
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let digits = "0123456789"
        let specialCharacters = "!@#$%^&*()-_=+[]{}|;:'\",.<>?/`~"

        // Ensure minimum criteria are met
        let requiredCharacters = [
            uppercaseLetters.randomElement()!,
            lowercaseLetters.randomElement()!,
            digits.randomElement()!,
            specialCharacters.randomElement()!
        ]

        // Create a pool of all allowed characters
        let allCharacters = uppercaseLetters + lowercaseLetters + digits + specialCharacters

        // Generate random characters to fill the remaining length
        let randomCharacters = (0..<(length - requiredCharacters.count)).map { _ in
            allCharacters.randomElement()!
        }

        // Combine required and random characters, then shuffle
        let passwordCharacters = (requiredCharacters + randomCharacters).shuffled()
        return String(passwordCharacters)
    }
}

struct PasswordCriteriaPopover: View {
    @Binding var password: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Password Criteria:")
                .font(.headline)
                .padding(.bottom, 5)
            criteriaText("• At least 8 characters", isValid: password.count >= 8)
            criteriaText("• At least 1 uppercase letter", isValid: containsUppercase(password))
            criteriaText("• At least 1 lowercase letter", isValid: containsLowercase(password))
            criteriaText("• At least 1 number", isValid: containsDigit(password))
            criteriaText("• At least 1 special character", isValid: containsSpecialCharacter(password))
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func criteriaText(_ text: String, isValid: Bool) -> some View {
        HStack {
            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isValid ? .green : .red)
            Text(text)
                .foregroundColor(isValid ? .green : .red)
        }
        .padding(.vertical, 2)
    }

    private func containsUppercase(_ text: String) -> Bool {
        let uppercaseLetterRegEx = ".*[A-Z]+.*"
        let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegEx)
        return uppercaseLetterTest.evaluate(with: text)
    }

    private func containsLowercase(_ text: String) -> Bool {
        let lowercaseLetterRegEx = ".*[a-z]+.*"
        let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegEx)
        return lowercaseLetterTest.evaluate(with: text)
    }

    private func containsDigit(_ text: String) -> Bool {
        let digitRegEx = ".*[0-9]+.*"
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        return digitTest.evaluate(with: text)
    }

    private func containsSpecialCharacter(_ text: String) -> Bool {
        let specialCharacterRegEx = ".*[!@#$%^&*()\\-_=+\\[{\\]}|;:'\",.<>?/`~]+.*"
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        return specialCharacterTest.evaluate(with: text)
    }
}
