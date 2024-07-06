
import SwiftUI

struct NoteUploadView: View {
    @Binding var notes: [Note]
    @State private var noteTitle: String = ""
    @State private var selectedNoteURL: URL?
    @State private var isShowingNotePicker = false

    var body: some View {
        VStack {
            CourseTextField(title: "Note Title", text: $noteTitle)
            Button(action: {
                isShowingNotePicker = true
            }) {
                Text("Select Note")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            if let selectedNoteURL = selectedNoteURL {
                Text("Selected Note: \(selectedNoteURL.lastPathComponent)")
            }
            Button(action: {
                if let selectedNoteURL = selectedNoteURL {
                    let note = Note(id: UUID(), title: noteTitle, url: selectedNoteURL)
                    notes.append(note)
                }
            }) {
                Text("Add Note")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding()
        }
        .sheet(isPresented: $isShowingNotePicker) {
            NotePicker(selectedURL: $selectedNoteURL, isPresented: $isShowingNotePicker)
        }
        .padding()
    }
}
