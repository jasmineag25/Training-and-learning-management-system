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
//    @State private var newVideo : Video?
    @Binding var videos: [Video]
    @State private var videoTitle: String = ""
    @State private var selectedVideoURL: URL?
    @State private var isShowingVideoPicker = false
    @State private var title : String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ScrollView {
                ForEach(videos.indices, id: \.self) { index in
                   courseVideo(video: $videos[index])
               }
            }
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
//            if let selectedVideoURL = selectedVideoURL {
//                Text("Selected Video: \(selectedVideoURL.lastPathComponent)")
//            }
        }
        .navigationBarItems(trailing: Button("Done") {
            
            presentationMode.wrappedValue.dismiss()
        })
        .sheet(isPresented: $isShowingVideoPicker) {
            VideoPicker(videos: $videos , selectedURL: $selectedVideoURL, isPresented: $isShowingVideoPicker)
        }
       
    }
}

//struct VideoUploadView_Previews: PreviewProvider {
//    struct Wrapper: View {
//        @State private var videos: [Video] = []
//
//        var body: some View {
//            NavigationView {
//                VideoUploadView(videos: $videos)
//            }
//        }
//    }
//
//    static var previews: some View {
//        Wrapper()
//    }
//}
//
