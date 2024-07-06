//import SwiftUI
//import UniformTypeIdentifiers
//
//struct QuizUploadView: View {
//    @State private var quizURLs: [URL?] = Array(repeating: nil, count: 10)
//    @State private var isShowingDocumentPicker = false
//    @State private var selectedNumberOfQuizzes: Int = 1
//    @State private var currentQuizIndex: Int?
//    @State private var showUploadConfirmationAlert = false
//    @Environment(\.presentationMode) var presentationMode
//
//    private let minFiles = 1
//    private let maxFiles = 10 // Maximum files allowed
//
//    var body: some View {
//        VStack {
//            Form {
//                Section(header: Text("Number of Quizzes to Upload")) {
//                    Stepper(value: $selectedNumberOfQuizzes, in: minFiles...maxFiles) {
//                        Text("Quizzes: \(selectedNumberOfQuizzes)")
//                    }
//                }
//
//                Section(header: Text("Quizzes Upload")) {
//                    ForEach(0..<selectedNumberOfQuizzes, id: \.self) { index in
//                        QuizUploadRowView(index: index, fileURLs: $quizURLs, isShowingDocumentPicker: $isShowingDocumentPicker, currentQuizIndex: $currentQuizIndex)
//                            .padding(.vertical, 4)
//                    }
//                }
//            }
//
//            Button(action: {
//                showUploadConfirmationAlert = true
//            }) {
//                Text("Upload")
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//            .padding()
//            .alert(isPresented: $showUploadConfirmationAlert) {
//                Alert(
//                    title: Text("Confirm Upload"),
//                    message: Text("Are you sure you want to upload the selected quizzes?"),
//                    primaryButton: .default(Text("Yes")) {
//                        uploadFiles()
//                        presentationMode.wrappedValue.dismiss()
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
//        }
//        .sheet(isPresented: $isShowingDocumentPicker) {
//            DocumentPicker(selectedURL: Binding(
//                get: { currentQuizIndex.flatMap { quizURLs.indices.contains($0) ? quizURLs[$0] : nil } },
//                set: { newValue in
//                    if let index = currentQuizIndex, let newValue = newValue {
//                        quizURLs[index] = newValue
//                    }
//                }
//            ), isPresented: $isShowingDocumentPicker)
//        }
//    }
//
//    private func uploadFiles() {
//        // Implement file upload logic here
//        for url in quizURLs.compactMap({ $0 }) {
//            // Simulate uploading quiz files
//            print("Uploading quiz file at URL: \(url)")
//        }
//    }
//}
//
//struct QuizUploadRowView: View {
//    let index: Int
//    @Binding var fileURLs: [URL?]
//    @Binding var isShowingDocumentPicker: Bool
//    @Binding var currentQuizIndex: Int?
//    @State private var quizTitle: String = ""
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            TextField("Quiz \(index + 1) Title", text: $quizTitle)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.bottom, 4)
//
//            HStack {
//                Button(action: {
//                    currentQuizIndex = index
//                    isShowingDocumentPicker = true
//                }) {
//                    Text("Select File")
//                        .foregroundColor(.white)
//                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//
//                Spacer()
//
//                Text(fileURLs[index]?.lastPathComponent ?? "No file selected")
//                    .foregroundColor(fileURLs[index] != nil ? .primary : .secondary)
//                    .font(.subheadline)
//            }
//        }
//        .padding(.vertical, 8)
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .cornerRadius(8)
//    }
//}
//
//
//
//struct QuizUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizUploadView()
//    }
//}
