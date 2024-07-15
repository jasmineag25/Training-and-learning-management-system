//import SwiftUI
//import AVKit
//import Firebase
//import FirebaseStorage
//import UIKit
//
//struct VideoPicker: UIViewControllerRepresentable {
//    @Binding var isPresented: Bool
//    @Binding var videoURL: URL?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.mediaTypes = ["public.movie"]
//        picker.sourceType = .photoLibrary
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: VideoPicker
//
//        init(_ parent: VideoPicker) {
//            self.parent = parent
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isPresented = false
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let url = info[.mediaURL] as? URL {
//                parent.videoURL = url
//            }
//            parent.isPresented = false
//        }
//    }
//}
//
//struct VideoPlayerView: View {
//    let videoURL: URL
//
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url: videoURL))
//            .frame(height: 300)
//    }
//}
//
//struct ContentView3: View {
//    @State private var isPickerPresented = false
//    @State private var videoURL: URL?
//    @State private var firebaseVideoURL: URL?
//
//    var body: some View {
//        VStack {
//            if let videoURL = videoURL {
//                VideoPlayerView(videoURL: videoURL)
//                Button(action: {
//                    print(videoURL)
//                    uploadVideoToFirebase(videoURL: videoURL) { url in
//                        if let urlString = url, let firebaseURL = URL(string: urlString) {
//                            DispatchQueue.main.async {
//                                self.firebaseVideoURL = firebaseURL
//                            }
//                        }
//                    }
////                    uploadVideo(url: videoURL)
//                }) {
//                    Text("Upload Video")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//
//               
//            } else {
//                Button("Select Video") {
//                    isPickerPresented = true
//                }
//            }
//
//            if let firebaseVideoURL = firebaseVideoURL {
//                VideoPlayerView(videoURL: firebaseVideoURL)
//            }
//        }
//        
//        .sheet(isPresented: $isPickerPresented) {
//            VideoPicker(isPresented: self.$isPickerPresented, videoURL: self.$videoURL)
//        }
//    }
//}
//
//func uploadVideoToFirebase(videoURL: URL, completion: @escaping (String?) -> Void) {
//    let storageRef = Storage.storage().reference().child("videos/\(UUID().uuidString).mp4")
//    storageRef.putFile(from: videoURL, metadata: nil) { metadata, error in
//        if let error = error {
//            print("Error uploading video: \(error.localizedDescription)")
//            completion(nil)
//            return
//        }
//        storageRef.downloadURL { url, error in
//            if let error = error {
//                print("Error fetching download URL: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            completion(url?.absoluteString)
//        }
//    }
//}
