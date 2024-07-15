////
////  VideoUploadView1.swift
////  Learn SwiftUI
////
////  Created by Madhav Verma on 11/07/24.
////
//
////import SwiftUI
////
////struct VideoUploadView: View {
////    @State private var isPickerPresented = false
////    @State private var videoURL: URL?
////    @State private var showAlert = false
////    @State private var alertMessage = ""
////
////    var body: some View {
////        VStack {
////            Button(action: {
////                self.isPickerPresented = true
////            }) {
////                Text("Select and Upload Video")
////            }
////            .padding()
////        }
////        .sheet(isPresented: $isPickerPresented) {
////            VideoPicker(isPresented: self.$isPickerPresented, videoURL: self.$videoURL)
////        }
////        .alert(isPresented: $showAlert) {
////            Alert(title: Text("Upload Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
////        }
////        .onChange(of: videoURL) { newVideoURL in
////            if let url = newVideoURL {
////                uploadVideo(url: url)
////            }
////        }
////    }
////
////    func uploadVideo(url: URL) {
////        a.uploadVideo(videoURL: url) { videoUrl in
////            if let videoUrl = videoUrl {
////                self.alertMessage = "Video uploaded successfully: \(videoUrl)"
////            } else {
////                self.alertMessage = "Failed to upload video"
////            }
////            self.showAlert = true
////        }
////    }
////}
////
////struct VideoUploadView_Previews: PreviewProvider {
////    static var previews: some View {
////        VideoUploadView()
////    }
////}
////
//
//
//import SwiftUI
//import AVKit
//import FirebaseStorage
//import FirebaseFirestore
//import FirebaseAuth
//
//struct VideoUploadView1: View {
//    @State private var isPickerPresented = false
//    @State private var videoURL: URL?
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//
//    var body: some View {
//        VStack {
//            if let videoURL = videoURL {
//                VideoPlayer(player: AVPlayer(url: videoURL))
//                    .frame(height: 300)
//                    .padding()
//
//                Button(action: {
//                    print(videoURL)
////                    uploadVideo(url: videoURL)
//                }) {
//                    Text("Upload Video")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            } else {
//                Text("No video selected")
//                    .padding()
//            }
//
//            Button(action: {
//                self.isPickerPresented = true
//            }) {
//                Text("Select Video")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isPickerPresented) {
//            VideoPicker(isPresented: self.$isPickerPresented, videoURL: self.$videoURL)
//        }
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Upload Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//    }
//
////    func uploadVideo(url: URL) {
////        PublitioManager.shared.uploadVideo(videoURL: url) { videoUrl in
////            if let videoUrl = videoUrl {
////                self.alertMessage = "Video uploaded successfully: \(videoUrl)"
////            } else {
////                self.alertMessage = "Failed to upload video"
////            }
////            self.showAlert = true
////        }
////    }
//}
//
////struct VideoUploadView_Previews: PreviewProvider {
////    static var previews: some View {
////        VideoUploadView1()
////    }
////}
////
////func submitCourseRequest(videoUrl : URL){
////    let courseID = UUID().uuidString
////    let email = "auth"
////    let name = "courseName"
////    let storageRef = Storage.storage().reference().child("courses").child("coursesVideos").child(email).child(name)
////
////    storageRef.putData(videoUrl) { metadata, error in
////        if let error = error {
////            print("Failed to upload image: \(error.localizedDescription)")
////            return
////        }
////        storageRef.downloadURL { url, error in
////            guard let videoURL = url?.absoluteString else {
////                return
////            }
//////            let courseData : Course = Course(id: courseID, email : email, name: name, description: description, duration: duration, language: language, price: price, category: category, keywords: keywords, imageUrl: imageURL)
////            let db = Firestore.firestore()
////            db.collection("coursesv").document(email).setData(videoURL) { err in
////                if let err = err {
////                    print("Error adding document: \(err)")
////                } else {
////                    print("Course added successfully")
////                }
////            }
////        }
////    }
////}
