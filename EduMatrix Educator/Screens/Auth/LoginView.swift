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
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                }
                            )
                            .padding(.top, 20)
                        if !isValidEmail(email) && !email.isEmpty {
                            Text("Please enter a valid email address.")
                                .font(.footnote)
                                .foregroundColor(.red)
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
                .overlay(
                    GeometryReader { geometry in
                        VStack {
                            if showPasswordDropdown {
                                Spacer(minLength: 50)
                                Button(action: {
                                    password = generateRandomPassword()
                                    showPasswordDropdown = false
                                }) {
                                    Text("Suggested Password: \(generateRandomPassword())")
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(5.0)
                                }
                                .padding(.top, 5)
                                .transition(.move(edge: .bottom))
                                .animation(.easeInOut)
                            }
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                    }
                )
        } else {
            SecureField("Password", text: $password)
                .onChange(of: password) { _ in
                    isPasswordFocused = true
                    isPopoverVisible = true
                }
.overlay(
GeometryReader { geometry in
    VStack {
        if showPasswordDropdown {
            Spacer(minLength: 50)
            Button(action: {
                password = generateRandomPassword()
                showPasswordDropdown = false
            }) {
                Text("Suggested Password: \(generateRandomPassword())")
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.top, 5)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut)
        }
    }
    .frame(width: geometry.size.width, alignment: .leading)
}
)
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
//                        if validateCredentials(email: email, password: password) {
        checkLoginCredentials(email: email, password: password)
    //}
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
.overlay(
Group {
if isPasswordFocused && !password.isEmpty && isPopoverVisible {
    PasswordCriteriaPopover(password: $password)
        .padding(.trailing, 140)
        .padding(.leading, 20)
        .padding(.top, 12)
        .transition(.move(edge: .bottom))
        .zIndex(1) // Ensure popover is above other views
        .background(
            Color.black.opacity(0.001)
                .onTapGesture {
                    isPopoverVisible = false
                }
        )
        .offset(y: 200) // Adjust the offset to position the popover below the password field
}
}
)
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

        // Randomly fill the rest of the password length
        let remainingLength = length - requiredCharacters.count
        let remainingCharacters = (0..<remainingLength).map { _ in allCharacters.randomElement()! }

        // Combine all characters and shuffle them to create the final password
        let passwordCharacters = (requiredCharacters + remainingCharacters).shuffled()
        return String(passwordCharacters)
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct PasswordCriteriaPopover: View {
    @Binding var password: String

    var body: some View {
        let criteria = passwordCriteriaCheck(password)

        return VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: criteria.uppercase ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(password.contains { $0.isUppercase } ? .green : .red)
                Text("At least one uppercase letter")
                    .font(.footnote)
                    .foregroundColor(password.contains { $0.isUppercase } ? .green : .red)
            }
            HStack {
                Image(systemName: criteria.lowercase ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(password.contains { $0.isLowercase } ? .green : .red)
                Text("At least one lowercase letter")
                    .font(.footnote)
                    .foregroundColor(password.contains { $0.isLowercase } ? .green : .red)
            }
            HStack {
                Image(systemName: criteria.digit ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(password.contains { $0.isNumber } ? .green : .red)
                Text("At least one digit")
                    .font(.footnote)
                    .foregroundColor(password.contains { $0.isNumber } ? .green : .red)
            }
            HStack {
                Image(systemName: criteria.specialChar ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(password.contains { !$0.isLetter && !$0.isNumber } ? .green : .red)
                Text("At least one special character")
                    .font(.footnote)
                    .foregroundColor(password.contains { !$0.isLetter && !$0.isNumber } ? .green : .red)
            }
            HStack {
                Image(systemName: criteria.length ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(password.count >= 8 ? .green : .red)
                Text("Minimum 8 characters")
                    .font(.footnote)
                    .foregroundColor(password.count >= 8 ? .green : .red)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func passwordCriteriaCheck(_ password: String) -> (uppercase: Bool, lowercase: Bool, digit: Bool, specialChar: Bool, length: Bool) {
        let uppercase = password.contains { $0.isUppercase }
        let lowercase = password.contains { $0.isLowercase }
        let digit = password.contains { $0.isNumber }
        let specialChar = password.contains { !$0.isLetter && !$0.isNumber }
        let length = password.count >= 8

        return (uppercase, lowercase, digit, specialChar, length)
    }
}
