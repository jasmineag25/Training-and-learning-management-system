import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct PersonalDetailsForm: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var about: String = ""
    @State private var mobileNumber: String = ""
    @State private var qualification: String = "Graduation"
    @State private var experience: String = "1 year"
    @State private var subjectDomains: Set<String> = []
    @State private var language: String = "English"
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var isShowingDomainPicker = false
    @State private var showAlert = false
    @State private var firstNameError = false
    @State private var lastNameError = false
    @State private var emailError = false
    @State private var mobileError = false

    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode

    let availableDomains = ["Web Tech", "Mobile App Development", "Data Science", "PCM", "PCB", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("First Name", text: $firstName)
                        .onChange(of: firstName) { newName in
                            firstNameError = newName.isEmpty || !isValidFirstName(newName)
                        }
                        .foregroundColor(firstNameError ? .red : .primary)
                        .textContentType(.name)
                        .autocapitalization(.words)
                    if firstNameError {
                        Text("Please enter a valid first name without spaces.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    TextField("Last Name", text: $lastName)
                        .onChange(of: lastName) { newLastName in
                            lastNameError = newLastName.isEmpty || !isValidName(newLastName)
                        }
                        .foregroundColor(lastNameError ? .red : .primary)
                        .textContentType(.name)
                        .autocapitalization(.words)
                    if lastNameError {
                        Text("Please enter a valid last name.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    TextField("E-Mail", text: $email)
                        .onChange(of: email) { newEmail in
                            emailError = !newEmail.isValidEmail
                        }
                        .foregroundColor(emailError ? .red : .primary)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                    if emailError {
                        Text("Please enter a valid email address.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    TextField("Mobile Number", text: $mobileNumber)
                        .onChange(of: mobileNumber) { newMobile in
                            mobileError = !newMobile.isValidPhoneNumber
                        }
                        .foregroundColor(mobileError ? .red : .primary)
                        .keyboardType(.phonePad)
                    if mobileError {
                        Text("Please enter a valid mobile number.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                Section(header: Text("Qualification")) {
                    Picker("Qualification", selection: $qualification) {
                        Text("High School").tag("High School")
                        Text("Sr. Secondary").tag("Sr. Secondary")
                        Text("Graduation").tag("Graduation")
                        Text("Post Graduation").tag("Post Graduation")
                        Text("Other").tag("Other")
                    }
                }

                Section(header: Text("Experience")) {
                    Picker("Experience", selection: $experience) {
                        Text("1 year").tag("1 year")
                        Text("2 years").tag("2 years")
                        Text("3 years").tag("3 years")
                        Text("4 years").tag("4 years")
                        Text("5 years").tag("5 years")
                        Text("More than 5 years").tag("More than 5 years")
                    }
                }

                Section(header: Text("Subjects/Domains")) {
                    Button(action: {
                        isShowingDomainPicker.toggle()
                    }) {
                        HStack {
                            Text("Select Domains")
                            Spacer()
                            if !subjectDomains.isEmpty {
                                Text("\(subjectDomains.count) selected")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingDomainPicker) {
                    DomainPickerView(selectedDomains: $subjectDomains, availableDomains: availableDomains)
                }

                Section(header: Text("Languages")) {
                    Picker("Languages", selection: $language) {
                        Text("English").tag("English")
                        Text("Hindi").tag("Hindi")
                        Text("Spanish").tag("Spanish")
                        Text("Other").tag("Other")
                    }
                }

                Section(header: Text("More About Yourself")) {
                    TextField("Your Achievements, Your Awards etc. ", text: $about).frame(height: 150)
                }
                Section(header: Text("Document Upload")) {
                    CourseImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                }

                Button(action: {
                    if validateFields() {
                        submitEducatorRequest(
                            name: firstName + " " + lastName,
                            aadharImage: selectedImage!,
                            profileImage: selectedImage!,
                            email: email,
                            mobileNumber: mobileNumber,
                            qualification: qualification,
                            experience: experience,
                            subjectDomain: subjectDomains.joined(separator: ", "),
                            language: language,
                            about: about
                        ) { success in
                            print(success)
                        }
                        showAlert = true
                    }
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirmation"),
                        message: Text("Your request has been submitted successfully."),
                        dismissButton: .default(Text("OK")) {
                            viewRouter.currentPage = .loginView
                        }
                    )
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePickerView(image: $selectedImage)
            }
            .navigationTitle("Personal Details")
//            .navigationBarItems(trailing: Button(action: {
//                viewRouter.currentPage = .onboardingScreen4
//            }) {
//                HStack {
//                    Text("Cancel")
//                }
//            })
        }
    }

    private func validateFields() -> Bool {
        firstNameError = firstName.isEmpty || !isValidFirstName(firstName)
        lastNameError = lastName.isEmpty || !isValidName(lastName)
        emailError = !email.isValidEmail
        mobileError = !mobileNumber.isValidPhoneNumber

        return !firstNameError && !lastNameError && !emailError && !mobileError
    }

    private func isValidFirstName(_ name: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: name)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    private func isValidName(_ name: String) -> Bool {
        let allowedCharacters = CharacterSet.letters.union(CharacterSet.whitespaces)
        let characterSet = CharacterSet(charactersIn: name)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct DomainPickerView: View {
    @Binding var selectedDomains: Set<String>
    let availableDomains: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List(availableDomains, id: \.self) { domain in
                MultipleSelectionRow(title: domain, isSelected: selectedDomains.contains(domain)) {
                    if selectedDomains.contains(domain) {
                        selectedDomains.remove(domain)
                    } else {
                        selectedDomains.insert(domain)
                    }
                }
            }
            .navigationTitle("Select Domains")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    var isValidPhoneNumber: Bool {
        let phoneRegex = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiView: UIImagePickerController, context: Context) {
        // Nothing to update
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct PersonalDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsForm()
    }
}
