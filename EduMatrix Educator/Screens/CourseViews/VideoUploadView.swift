
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
        .padding()
       
    }
}
