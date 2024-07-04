
import SwiftUI

struct PersonalDetailsForm: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var mobileNumber: String = ""
    @State private var qualification: String = "Graduation"
    @State private var experience: String = "1 year"
    @State private var subjectDomain: String = "Web Tech"
    @State private var language: String = "English"
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var isUploadingImage = false

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

                Section(header: Text("Document Upload")) {
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                               .resizable()
                               .frame(maxWidth:.infinity, maxHeight: 200)
                               .clipped()
                        } else {
                            Text("No image selected")
                        }
                        if isUploadingImage {
                            ProgressView()
                        } else {
                            Button(action: {
                                self.isShowingImagePicker = true
                                // Upload the selected image here
                                //...
                            }) {
                                Text("Upload")
                                   .frame(maxWidth:.infinity,maxHeight: 12)
                                   .padding()
                                   .background(Color.blue)
                                   .foregroundColor(.white)
                                   .cornerRadius(8)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePickerView(image: $selectedImage)
                }

//                Section {
//                    Button(action: {
//                        // Handle form submission here
//                        print("Form submitted!")
//                    }) {
//                        Text("Submit")
//                            .frame(maxWidth:.infinity, maxHeight: 12)
//                           .padding()
//                           .background(Color.blue)
//                           .foregroundColor(.white)
//                           .cornerRadius(8)
//                    }
//                }
                Button(action: {
                    // Reset all the data
                    self.name = ""
                    self.email = ""
                    self.mobileNumber = ""
                    self.qualification = "Graduation"
                    self.experience = "1 year"
                    self.subjectDomain = "Web Tech"
                    self.language = "English"
                    self.selectedImage = nil
                    print("Form submitted")
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


