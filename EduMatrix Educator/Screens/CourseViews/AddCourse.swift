
import SwiftUI
import FirebaseFirestore
import UniformTypeIdentifiers
import FirebaseAuth

struct CourseDetailsView: View {
    @Binding var courses: [Course]
    @State private var courseName: String = ""
    @State private var courseDescription: String = ""
    @State private var courseDuration: String = ""
    @State private var courseLanguage: String = "Select Language"
    @State private var coursePrice: String = ""
    @State private var category: String = "Select Category"
    @State private var selectedImage: UIImage?
    @State private var selectedURL: URL?
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    @State private var selectedKeywords: String = "Select Keywords"
    @State private var videos: [Video] = []
    @State private var notes: [Note] = []
    @Environment(\.presentationMode) var presentationMode

    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    let categories = ["Swift", "UI/UX", "SwiftUI", "Web Development", "UIKit"]
    let allKeywords = ["HTML", "CSS", "JavaScript", "Python", "Java", "Swift"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CourseTextField(title: "Course Name", text: $courseName)
                CourseTextField(title: "Course Description", text: $courseDescription)
                CourseTextField(title: "Course Duration", text: $courseDuration)
                NavigationLinkButtons(videos: $videos, notes: $notes)
                CoursePicker(title: "Course Language", selection: $courseLanguage, options: languages)
                CoursePicker(title: "Course Keywords", selection: $selectedKeywords, options: allKeywords)
                CourseTextField(title: "Course Price", text: $coursePrice, keyboardType: .decimalPad)
                CoursePicker(title: "Category", selection: $category, options: categories)
                CourseImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                SubmitButton(showAlert: $showAlert, action: {
                    guard let email = Auth.auth().currentUser?.email else { return }
                    let db = Firestore.firestore().collection("educators").document(email)
                        db.getDocument(){ (snap, error) in
                        if let error = error {
                            print("Error getting documents: \(error.localizedDescription)")
                        }
                        else {
                            let data = snap?.data()
                            let name = data!["name"] as! String
                            print(name)
                            submitCourseRequest(name: courseName, description: courseDescription, duration: courseDuration, price: coursePrice, category: category, keywords: selectedKeywords, image: selectedImage! , language: courseLanguage,email: email, educatorName: name, videos: videos) {success in
                                print(success)
                            }

                        }
                    }
                    showAlert = true
                })
            }
            .padding()
        }
        .background(Color("F2F2F7"))
        .navigationTitle("Course Details")
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedURL: $selectedURL, isPresented: $isShowingImagePicker, mediaTypes: ["public.image"])
                .onDisappear {
                    if let selectedURL = selectedURL, let image = UIImage(contentsOfFile: selectedURL.path) {
                        self.selectedImage = image
                    }
                }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Course Submitted"),
                message: Text("Your course has been updated and submitted to admin for approval."),
                dismissButton: .default(Text("OK")) {
                    // Clear all fields
                    clearFields()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    func clearFields() {
        courseName = ""
        courseDescription = ""
        courseDuration = ""
        courseLanguage = "Select Language"
        coursePrice = ""
        category = "Select Category"
        selectedImage = nil
        selectedKeywords.removeAll()
        videos.removeAll()
        notes.removeAll()
    }
}

struct CourseDetailsView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var course: [Course] = []

        var body: some View {
            NavigationView {
                CourseDetailsView(courses: $course)
            }
        }
    }

    static var previews: some View {
        Wrapper()
    }
}
