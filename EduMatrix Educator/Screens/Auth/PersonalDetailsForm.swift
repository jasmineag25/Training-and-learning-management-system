import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct PersonalDetailsForm: View {
    //@AppStorage("isDarkMode") private var isDarkMode = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var about: String = ""
    @State private var aadharImage : UIImage?
    @State private var mobileNumber: String = ""
    @State private var qualification: String = "Graduation"
    @State private var experience: String = "1 year"
    @State private var subjectDomain: String = "Web Tech"
    @State private var language: String = "English"
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Name", text: $name)
                    TextField("E-Mail", text: $email)
                    TextField("Mobile Number", text: $mobileNumber)
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
                        Text("More than 5 years").tag("More than 5 years ")
                    }
                }

                Section(header: Text("Subjects/Domains")) {
                    Picker("Subjects/Domains", selection: $subjectDomain) {
                        Text("Web Tech").tag("Web Tech")
                        Text("Mobile App Development").tag("Mobile App Development")
                        Text("Data Science").tag("Data Science")
                        Text("PCM").tag("PCM")
                        Text("PCB").tag("PCB")
                        Text("Other").tag("Other")
                    }
                }

                Section(header: Text("Languages")) {
                    Picker("Languages", selection: $language) {
                        Text("English").tag("English")
                        Text("Hindi").tag("Hindi")
                        Text("Spanish").tag("Spanish")
                        Text("Other").tag("Other")
                    }
                }

                Section(header: Text("More About Yourself")){
                    TextField("Your Achievements, Your Awards etc. ", text: $about).frame(height: 150)
                }
                Section(header: Text("Document Upload")) {
                    CourseImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                }
                
                Button(action: {
                    submitEducatorRequest(name: name, aadharImage: selectedImage!,profileImage: selectedImage!, email: email, mobileNumber: mobileNumber, qualification: qualification, experience: experience, subjectDomain: subjectDomain, language: language, about: about){ success in
                        print(success)
                        
                    }
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Submit")
                      .frame(maxWidth:.infinity)
                      .padding()
                      .background(Color.blue)
                      .foregroundColor(.white)
                      .cornerRadius(8)
                }
                
            }
           .sheet(isPresented: $isShowingImagePicker) {
                ImagePickerView(image: $selectedImage)
            }
           .navigationTitle("Personal Details")
           
        }
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
