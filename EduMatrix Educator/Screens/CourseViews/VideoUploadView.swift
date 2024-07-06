
import SwiftUI

struct VideoUploadView: View {
    @Binding var videos: [Video]
    @State private var videoTitle: String = ""
    @State private var selectedVideoURL: URL?
    @State private var isShowingVideoPicker = false

    var body: some View {
        VStack {
            CourseTextField(title: "Video Title", text: $videoTitle)
            Button(action: {
                isShowingVideoPicker = true
            }) {
                Text("Select Video")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            if let selectedVideoURL = selectedVideoURL {
                Text("Selected Video: \(selectedVideoURL.lastPathComponent)")
            }
            Button(action: {
                if let selectedVideoURL = selectedVideoURL {
                    let video = Video(id: UUID(), title: videoTitle, url: selectedVideoURL)
                    videos.append(video)
                }
            }) {
                Text("Add Video")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding()
        }
        .sheet(isPresented: $isShowingVideoPicker) {
            VideoPicker(selectedURL: $selectedVideoURL, isPresented: $isShowingVideoPicker)
        }
        .padding()
    }
}
