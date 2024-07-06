
import SwiftUI
import UniformTypeIdentifiers

struct NoteUploadView: View {
    @State private var noteURLs: [URL?] = Array(repeating: nil, count: 10)
    @State private var isShowingDocumentPicker = false
    @State private var selectedNumberOfNotes: Int = 1
    @State private var currentNoteIndex: Int?
    @State private var showUploadConfirmationAlert = false
    @Environment(\.presentationMode) var presentationMode

    private let minFiles = 1
    private let maxFiles = 10 // Maximum files allowed

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Number of Notes to Upload")) {
                    Stepper(value: $selectedNumberOfNotes, in: minFiles...maxFiles) {
                        Text("Notes: \(selectedNumberOfNotes)")
                    }
                }

                Section(header: Text("Notes Upload")) {
                    ForEach(0..<selectedNumberOfNotes, id: \.self) { index in
                        NoteUploadRowView(index: index, fileURLs: $noteURLs, isShowingDocumentPicker: $isShowingDocumentPicker, currentNoteIndex: $currentNoteIndex)
                            .padding(.vertical, 4)
                    }
                }
            }

            Button(action: {
                showUploadConfirmationAlert = true
            }) {
                Text("Upload")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .alert(isPresented: $showUploadConfirmationAlert) {
                Alert(
                    title: Text("Confirm Upload"),
                    message: Text("Are you sure you want to upload the selected notes?"),
                    primaryButton: .default(Text("Yes")) {
                        uploadFiles()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .sheet(isPresented: $isShowingDocumentPicker) {
            DocumentPicker(selectedURL: Binding(
                get: { currentNoteIndex.flatMap { noteURLs.indices.contains($0) ? noteURLs[$0] : nil } },
                set: { newValue in
                    if let index = currentNoteIndex, let newValue = newValue {
                        noteURLs[index] = newValue
                    }
                }
            ), isPresented: $isShowingDocumentPicker)
        }
    }

    private func uploadFiles() {
        // Implement file upload logic here
        for url in noteURLs.compactMap({ $0 }) {
            // Simulate uploading note files
            print("Uploading note file at URL: \(url)")
        }
    }
}

struct NoteUploadRowView: View {
    let index: Int
    @Binding var fileURLs: [URL?]
    @Binding var isShowingDocumentPicker: Bool
    @Binding var currentNoteIndex: Int?
    @State private var noteTitle: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Note \(index + 1) Title", text: $noteTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 4)

            HStack {
                Button(action: {
                    currentNoteIndex = index
                    isShowingDocumentPicker = true
                }) {
                    Text("Select File")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()

                Text(fileURLs[index]?.lastPathComponent ?? "No file selected")
                    .foregroundColor(fileURLs[index] != nil ? .primary : .secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        let parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.selectedURL = urls.first
            parent.isPresented = false
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.isPresented = false
        }
    }
}

struct NoteUploadView_Previews: PreviewProvider {
    static var previews: some View {
        NoteUploadView()
    }
}
