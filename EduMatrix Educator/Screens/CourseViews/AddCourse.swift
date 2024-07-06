
import SwiftUI
import UniformTypeIdentifiers

struct CourseDetailsView: View {
    @Binding var courses: [Course]
    
    @State private var courseName: String = ""
    @State private var courseDescription: String = ""
    @State private var courseDuration: String = ""
    @State private var courseLanguage: String = "Select Language"
    @State private var coursePrice: String = ""
    @State private var keywords: String = "Select Category"
    @State private var selectedImage: UIImage?
    @State private var selectedURL: URL?
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    @State private var selectedKeywords: [String] = []
    @EnvironmentObject var courseStore: CourseStore
    @Environment(\.presentationMode) var presentationMode
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    let categories = ["Swift", "UI/UX", "SwiftUI", "Web Development", "UIKit"]
    let allKeywords = ["HTML", "CSS", "JavaScript", "Python", "Java", "Swift"]
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Course details input fields
                    Group {
                        Text("Course Name")
                            .font(.headline)
                            .padding(.top)
                        TextField("Enter course name", text: $courseName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                        Text("Course Description")
                            .font(.headline)
                            .padding(.top)
                        TextField("Enter course description", text: $courseDescription)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                        
                        Text("Course Duration")
                            .font(.headline)
                        TextField("Enter Course Duration", text: $courseDuration)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                        
                        Text("Course Content")
                            .font(.headline)
                        
                        // Buttons to navigate to file upload views
                        NavigationLink(destination: VideoUploadView()) {
                            HStack {
                                Text("Upload Videos")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding(.vertical)
                        
                        NavigationLink(destination: NoteUploadView()) {
                            HStack {
                                Text("Upload Notes")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding(.vertical)
                        
//                        NavigationLink(destination: QuizUploadView()) {
//                            HStack {
//                                Text("Upload Quizzes")
//                                    .foregroundColor(.black)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                            }
//                        }
//                        .padding(.vertical)
                    }
                    
                    // Additional course details input fields
                    Group {
                        Text("Course Language")
                            .font(.headline)
                            .padding(.top)
                        Menu {
                            ForEach(languages, id: \.self) { language in
                                Button(action: {
                                    courseLanguage = language
                                }) {
                                    Text(language)
                                }
                            }
                        } label: {
                            HStack {
                                Text(courseLanguage)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(courseLanguage == "Select Language" ? Color.gray.opacity(0.2) : Color.white)
                            .cornerRadius(8)
                        }
                        .padding(.bottom)
                        
                        Text("Course Keywords")
                            .font(.headline)
                            .padding(.top)
                        Menu {
                            ForEach(allKeywords, id: \.self) { keyword in
                                Button(action: {
                                    if selectedKeywords.contains(keyword) {
                                        selectedKeywords.removeAll { $0 == keyword }
                                    } else {
                                        selectedKeywords.append(keyword)
                                    }
                                }) {
                                    HStack {
                                        Text(keyword)
                                        Spacer()
                                        if selectedKeywords.contains(keyword) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedKeywords.isEmpty ? "Select Keywords" : selectedKeywords.joined(separator: ", "))
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(selectedKeywords.isEmpty ? Color.gray.opacity(0.2) : Color.white)
                            .cornerRadius(8)
                        }
                        .padding(.bottom)
                        
                        Text("Course Price")
                            .font(.headline)
                        TextField("Enter Course Price", text: $coursePrice)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding(.bottom)
                        
                        Text("Category")
                            .font(.headline)
                            .padding(.top)
                        Menu {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    keywords = category
                                }) {
                                    Text(category)
                                }
                            }
                        } label: {
                            HStack {
                                Text(keywords)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(keywords == "Select Category" ? Color.gray.opacity(0.2) : Color.white)
                            .cornerRadius(8)
                        }
                        .padding(.bottom)
                        
                        Text("Course Image")
                            .font(.headline)
                        HStack {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(8)
                            } else {
                                Text("No file selected")
                            }
                            Spacer()
                            Button(action: {
                                isShowingImagePicker = true
                            }) {
                                Text("Upload")
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom)
                        
                        // Button to send request
                        Button(action: {
                            onSendRequest()
                        }) {
                            Text("Send Request")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding(.top)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Course Submitted"),
                                message: Text("Your course has been updated and submitted to admin for approval."),
                                dismissButton: .default(Text("OK")) {
                                    // Clear all fields
                                    courseName = ""
                                    courseDescription = ""
                                    courseDuration = ""
                                    courseLanguage = "Select Language"
                                    coursePrice = ""
                                    keywords = "Select Category"
                                    selectedImage = nil
                                    selectedKeywords.removeAll()
                                    presentationMode.wrappedValue.dismiss()
                                }
                            )
                        }
                    }
                }
                .padding()
                
            }
            .background(Color(hex: "F2F2F7"))
            .navigationTitle("Course Details")
//            .navigationBarItems(leading: Button("Cancel", action: {
//                // Action for Cancel button
//            }), trailing: Button("Done", action: {
//                // Action for Done button
//            }))
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedURL: $selectedURL, isPresented: $isShowingImagePicker, mediaTypes: ["public.image"])
                    .onDisappear {
                        if let selectedURL = selectedURL, let image = UIImage(contentsOfFile: selectedURL.path) {
                            self.selectedImage = image
                        }
                    }
            }
        }
    
    func onSendRequest() {
        let course = Course(id: UUID(), title: "Web Development", author: "Shahiyan Khan" , rating: 9, price: "$110", imageName: "course4")
        self.courses.append(course)
        showAlert = true
    }
    }
//}
//
//struct CourseDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseDetailsView()
//    }
//}
/*
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool
    var mediaTypes: [String]
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.selectedURL = url
            } else if let image = info[.originalImage] as? UIImage, let data = image.jpegData(compressionQuality: 1.0) {
                let tempDirectory = FileManager.default.temporaryDirectory
                let fileName = UUID().uuidString + ".jpg"
                let fileURL = tempDirectory.appendingPathComponent(fileName)
                try? data.write(to: fileURL)
                parent.selectedURL = fileURL
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}
*/
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool
    var mediaTypes: [String]
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.selectedURL = url
            } else if let image = info[.originalImage] as? UIImage, let data = image.jpegData(compressionQuality: 1.0) {
                let tempDirectory = FileManager.default.temporaryDirectory
                let fileName = UUID().uuidString + ".jpg"
                let fileURL = tempDirectory.appendingPathComponent(fileName)
                try? data.write(to: fileURL)
                parent.selectedURL = fileURL
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
