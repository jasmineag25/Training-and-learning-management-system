//
//import SwiftUI
//
//struct VideoUploadView: View {
//    @Binding var videos: [Video]
//    @State private var videoTitle: String = ""
//    @State private var selectedVideoURL: URL?
//    @State private var isShowingVideoPicker = false
//
//    var body: some View {
//        VStack {
//            CourseTextField(title: "Video Title", text: $videoTitle)
//            Button(action: {
//                isShowingVideoPicker = true
//            }) {
//                Text("Select Video")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(8)
//                    .frame(width: .infinity)
//            }
//            .padding()
//            if let selectedVideoURL = selectedVideoURL {
//                Text("Selected Video: \(selectedVideoURL.lastPathComponent)")
//            }
//            Button(action: {
//                if let selectedVideoURL = selectedVideoURL {
//                    let video = Video(id: UUID(), title: videoTitle, url: selectedVideoURL)
//                    videos.append(video)
//                }
//            }) {
//                Text("Add Video")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.green)
//                    .cornerRadius(8)
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isShowingVideoPicker) {
//            VideoPicker(selectedURL: $selectedVideoURL, isPresented: $isShowingVideoPicker)
//        }
//        .padding()
//    }
//}
//
import SwiftUI

struct VideoUploadView: View {
    @Binding var videos: [Video]
    @State private var videoTitle: String = ""
    @State private var selectedVideoURL: URL?
    @State private var isShowingVideoPicker = false
    @Environment(\.presentationMode) var presentationMode

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
                    .frame(maxWidth: .infinity)
            }
            .padding()
            if let selectedVideoURL = selectedVideoURL {
                Text("Selected Video: \(selectedVideoURL.lastPathComponent)")
            }
        }
        .navigationBarItems(trailing: Button("Done") {
            if let selectedVideoURL = selectedVideoURL, !videoTitle.isEmpty {
                let video = Video(id: UUID(), title: videoTitle, url: selectedVideoURL)
                videos.append(video)
            }
            presentationMode.wrappedValue.dismiss()
        })
        .sheet(isPresented: $isShowingVideoPicker) {
            VideoPicker(selectedURL: $selectedVideoURL, isPresented: $isShowingVideoPicker)
        }
        .padding()
    }
}

struct VideoUploadView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var videos: [Video] = []

        var body: some View {
            NavigationView {
                VideoUploadView(videos: $videos)
            }
        }
    }

    static var previews: some View {
        Wrapper()
    }
}


