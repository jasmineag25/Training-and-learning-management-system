import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct PersonalDetailsForm: View {
    @State private var firstName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var about: String = ""
    @State private var aadharImage: UIImage? = nil
    @State private var mobileNumber: String = ""
    @State private var qualification: String = "Not Selected"
    @State private var experience: String = "1 year"
    @State private var subjectDomain: [String] = []
    @State private var language: [String] = []
    @State private var profileImage: UIImage? = UIImage(systemName: "person.circle")

    @State private var selectedURL: URL?
    
    @State private var showAlert = false
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var alertMessage = ""
    
    @State private var isShowingProfileImagePicker = false //Profile Image Picker
    @State private var isShowingAadharImagePicker = false //Aadhaar Image Picker
    @State private var isprofileImage : Bool = false
    @State private var isShowingActionSheet = false //Add state variable
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary //Add state variable
    
    @Environment(\.presentationMode) var presentationMode
    
    // Validation States
    @State private var firstNameError: String? = nil
    @State private var middleNameError: String? = nil
    @State private var lastNameError: String? = nil
    @State private var emailError: String? = nil
    @State private var mobileNumberError: String? = nil
    @State private var aboutError: String? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    VStack {
                        Image(uiImage: profileImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100) // Set a fixed size for the image
                            .onTapGesture {
                                isprofileImage = true
                                isShowingActionSheet = true
                            }
                        
                    }
                    .frame(maxWidth: .infinity) // Center the content within the parent view
                    .padding()
                }

                Section(header: Text("Personal Details")) {
                    TextField("First Name", text: $firstName)
                        .onChange(of: firstName) { _ in validateFirstName() }
                    if let error = firstNameError {
                        Text(error).foregroundColor(.red).font(.caption)
                    }
                    
                    TextField("Middle Name (Optional)", text: $middleName)
                        .onChange(of: middleName) { _ in validateMiddleName() } // Highlight: validation on change
                    if let error = middleNameError { // Highlight: added error display for middle name
                        Text(error).foregroundColor(.red).font(.caption)
                    }
                    
                    TextField("Last Name (Optional)", text: $lastName)
                        .onChange(of: lastName) { _ in validateLastName() } // Highlight: validation on change
                    if let error = lastNameError { // Highlight: added error display for last name
                        Text(error).foregroundColor(.red).font(.caption)
                    }
                    
                    TextField("E-Mail", text: $email)
                        .autocapitalization(.none)
                        .onChange(of: email) { _ in validateEmail() }
                    if let error = emailError {
                        Text(error).foregroundColor(.red).font(.caption)
                    }
                    
                    TextField("Mobile Number", text: $mobileNumber)
                        .onChange(of: mobileNumber) { _ in validateMobileNumber() }
                    if let error = mobileNumberError {
                        Text(error).foregroundColor(.red).font(.caption)
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
                    MultipleSelectionPicker(title: "Subjects/Domains",
                                            selection: $subjectDomain,
                                            options: [
                                                "Web Tech",
                                                "Mobile App Development",
                                                "Data Science",
                                                "PCM",
                                                "PCB",
                                                "Other"
                                            ])
                    Text("\(subjectDomain.joined(separator: ", "))")
                }
                
                Section(header: Text("Languages")) {
                    MultipleSelectionPicker(title: "Languages",
                                            selection: $language,
                                            options: [
                                                "English",
                                                "Hindi",
                                                "Spanish",
                                                "Other"
                                            ])
                    Text("\(language.joined(separator: ", "))")
                }
                
                Section(header: Text("More About Yourself")) {
                    TextEditor(text: $about)
                        .frame(minHeight: 100)
                        .lineLimit(nil) // Highlight: word wrap enabled
                        .onChange(of: about) { _ in validateAbout() }
                    if let error = aboutError {
                        Text(error).foregroundColor(.red).font(.caption)
                    }
                }
                
                // Aadhaar Image Section
                Section(header: Text("Document Upload")) {
                    HStack{
                        if let selectedAadharImage = aadharImage {
                            Image(uiImage: selectedAadharImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .onTapGesture {
                                    isprofileImage = false
                                    isShowingActionSheet = true
                                }
                        } else {
                            Text("No document")
                        }
                        
                        Spacer()
                        if aadharImage == nil {
                            Button(action: {
                                isprofileImage = false
                                isShowingActionSheet = true
                            }) {
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                
                Button(action: {
                    if validateForm() {
                        submitEducatorRequest(
                            firstName: firstName,
                            middleName: middleName,
                            lastName: lastName,
                            aadharImage: aadharImage!,
                            profileImage: aadharImage!,
                            email: email,
                            mobileNumber: mobileNumber,
                            qualification: qualification,
                            experience: experience,
                            subjectDomain: subjectDomain,
                            language: language,
                            about: about
                        ) { success in
                            print(success)
                            showAlert = true
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .opacity(validateForm() ? 1.0 : 0.5)
                        .disabled(!validateForm())
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Confirmation"), message: Text("Request sent successfully"), dismissButton: .default(Text("Ok")){
                        resetForm()
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
            .onAppear {
                resetForm() // Call resetForm() when the view appears
            }
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(
                    title: Text("Select Image"),
                    buttons: [
                        .default(Text("Camera")) {
                            imageSource = .camera
                            if isprofileImage {
                                isShowingProfileImagePicker = true
                            } else {
                                isShowingAadharImagePicker = true
                            }
                        },
                        .default(Text("Photo Library")) {
                            imageSource = .photoLibrary
                            if isprofileImage {
                                isShowingProfileImagePicker = true
                            } else {
                                isShowingAadharImagePicker = true
                            }
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $isShowingProfileImagePicker) {
                ImagePickerView(image: $profileImage, sourceType: imageSource)
            }
            .sheet(isPresented: $isShowingAadharImagePicker) {
                ImagePickerView(image: $aadharImage, sourceType: imageSource)
            }
            .navigationTitle("Personal Details")
        }
    }
    
    // Validation Functions
    private func validateFirstName() {
        if firstName.isEmpty {
            firstNameError = "First name is required"
        } else if !isValidName(firstName) {
            firstNameError = "First name must not contain numbers or special characters"
        } else {
            firstNameError = nil
        }
    }
    
    private func validateMiddleName() {
        if !middleName.isEmpty && !isValidName(middleName) {
            middleNameError = "Middle name must not contain numbers or special characters" // Highlight: validation message
        } else {
            middleNameError = nil
        }
    }
    
    private func validateLastName() {
        if !lastName.isEmpty && !isValidName(lastName) {
            lastNameError = "Last name must not contain numbers or special characters" // Highlight: validation message
        } else {
            lastNameError = nil
        }
    }
    
    private func validateEmail() {
        if email.isEmpty {
            emailError = "Email is required"
        } else if !isValidEmail(email) {
            emailError = "Email must be in the format 'example@example.com'"
        } else {
            emailError = nil
        }
    }
    
    private func validateMobileNumber() {
        if mobileNumber.isEmpty {
            mobileNumberError = "Mobile number is required"
        } else if !isValidMobileNumber(mobileNumber) {
            mobileNumberError = "Mobile number must be exactly 10 digits"
        } else {
            mobileNumberError = nil
        }
    }
    
    private func validateAbout() {
        if about.trimmingCharacters(in: .whitespaces).isEmpty && !about.isEmpty {
            aboutError = "Description cannot be only spaces"
        } else {
            aboutError = nil
        }
    }
    
    private func validateForm() -> Bool {
        validateFirstName()
        validateMiddleName()
        validateLastName()
        validateEmail()
        validateMobileNumber()
        validateAbout()
        
        return firstNameError == nil && middleNameError == nil && lastNameError == nil && emailError == nil && mobileNumberError == nil && aboutError == nil
    }
    
    private func isValidName(_ name: String) -> Bool {
        let nameRegEx = "^[a-zA-Z]+$"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidMobileNumber(_ mobileNumber: String) -> Bool {
        let mobileRegEx = "^[0-9]{10}$"
        let mobilePred = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: mobileNumber)
    }
    
    private func resetForm() {
        firstName = ""
        middleName = ""
        lastName = ""
        email = ""
        about = ""
        aadharImage = nil
        mobileNumber = ""
        qualification = "Graduation"
        experience = "1 year"
        subjectDomain = ["Web Tech"]
        language = ["English"]
        isShowingProfileImagePicker = false
        isShowingAadharImagePicker = false
        isShowingActionSheet = false
        showAlert = false
        
        // Reset validation errors
        firstNameError = nil
        middleNameError = nil
        lastNameError = nil
        emailError = nil
        mobileNumberError = nil
        aboutError = nil
    }
}

struct MultipleSelectionPicker: View {
    let title: String
    @Binding var selection: [String]
    let options: [String]
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    if self.selection.contains(option) {
                        self.selection.removeAll(where: { $0 == option })
                    } else {
                        self.selection.append(option)
                    }
                }) {
                    HStack {
                        Text(option)
                        if self.selection.contains(option) {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(title)
                Spacer()
                Text("Select")
            }
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
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
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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
