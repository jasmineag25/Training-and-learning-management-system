//
//  VideoUploadView.swift
//  CourseDetails
//
//  Created by Divyanshu rai on 04/07/24.
/*


import SwiftUI

struct VideoUploadView: View {
    @State private var videoURLs: [URL] = []
    @State private var isShowingImagePicker = false
    @State private var selectedNumberOfVideos: Int = 1
    @State private var currentVideoIndex: Int?
    @State private var showUploadConfirmationAlert = false
    @Environment(\.presentationMode) var presentationMode

    private let minFiles = 1
    private let maxFiles = 10 // Maximum files allowed

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Number of Videos to Upload")) {
                    Stepper(value: $selectedNumberOfVideos, in: minFiles...maxFiles) {
                        Text("Videos: \(selectedNumberOfVideos)")
                    }
                }

                Section(header: Text("Videos Upload")) {
                    ForEach(0..<selectedNumberOfVideos, id: \.self) { index in
                        VideoUploadRowView(index: index + 1, fileURLs: $videoURLs, isShowingImagePicker: $isShowingImagePicker, currentVideoIndex: $currentVideoIndex)
                            .padding(.vertical, 4)
                    }
                }
            }

            Button(action: {
                showUploadConfirmationAlert = true
            }) {
                Text("Upload All")
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
                    message: Text("Are you sure you want to upload the selected videos?"),
                    primaryButton: .default(Text("Yes")) {
                        uploadFiles()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedURL: Binding(
                get: { currentVideoIndex.flatMap { videoURLs.indices.contains($0) ? videoURLs[$0] : nil } },
                set: { newValue in
                    if let index = currentVideoIndex, let newValue = newValue {
                        if index < videoURLs.count {
                            videoURLs[index] = newValue
                        } else {
                            videoURLs.append(newValue)
                        }
                    }
                }
            ), isPresented: $isShowingImagePicker, mediaTypes: ["public.movie"])
        }
    }

    private func uploadFiles() {
        // Implement file upload logic here
        for url in videoURLs {
            // Simulate uploading video files
            print("Uploading video file at URL: \(url)")
        }
    }
}

struct VideoUploadRowView: View {
    let index: Int
    @Binding var fileURLs: [URL]
    @Binding var isShowingImagePicker: Bool
    @Binding var currentVideoIndex: Int?
    @State private var videoTitle: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Video \(index) Title", text: $videoTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 4)

            HStack {
                Button(action: {
                    currentVideoIndex = index - 1
                    isShowingImagePicker = true
                }) {
                    Text("Select File")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()

                Text(fileURLs.indices.contains(index - 1) ? "File Selected: \(fileURLs[index - 1].lastPathComponent)" : "No file selected")
                    .foregroundColor(fileURLs.indices.contains(index - 1) ? .primary : .secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct VideoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        VideoUploadView()
    }
}

*/
import SwiftUI

struct VideoUploadView: View {
    @State private var videoURLs: [URL?] = Array(repeating: nil, count: 10)
    @State private var isShowingImagePicker = false
    @State private var selectedNumberOfVideos: Int = 1
    @State private var currentVideoIndex: Int?
    @State private var showUploadConfirmationAlert = false
    @Environment(\.presentationMode) var presentationMode

    private let minFiles = 1
    private let maxFiles = 10 // Maximum files allowed

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Number of Videos to Upload")) {
                    Stepper(value: $selectedNumberOfVideos, in: minFiles...maxFiles) {
                        Text("Videos: \(selectedNumberOfVideos)")
                    }
                }

                Section(header: Text("Videos Upload")) {
                    ForEach(0..<selectedNumberOfVideos, id: \.self) { index in
                        VideoUploadRowView(index: index + 1, videoURLs: $videoURLs, isShowingImagePicker: $isShowingImagePicker, currentVideoIndex: $currentVideoIndex)
                            .padding(.vertical, 4)
                    }
                }
            }

            Button(action: {
                showUploadConfirmationAlert = true
            }) {
                Text("Upload All")
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
                    message: Text("Are you sure you want to upload the selected videos?"),
                    primaryButton: .default(Text("Yes")) {
                        uploadFiles()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedURL: Binding(
                get: {
                    if let currentIndex = currentVideoIndex, videoURLs.indices.contains(currentIndex) {
                        return videoURLs[currentIndex]
                    } else {
                        return nil
                    }
                },
                set: { newValue in
                    if let currentIndex = currentVideoIndex, videoURLs.indices.contains(currentIndex) {
                        videoURLs[currentIndex] = newValue
                    }
                }
            ), isPresented: $isShowingImagePicker, mediaTypes: ["public.movie"])
        }
    }

    private func uploadFiles() {
        // Implement file upload logic here
        for url in videoURLs {
            if let url = url {
                // Simulate uploading video files
                print("Uploading video file at URL: \(url)")
            }
        }
    }
}


struct VideoUploadRowView: View {
    let index: Int
    @Binding var videoURLs: [URL?]
    @Binding var isShowingImagePicker: Bool
    @Binding var currentVideoIndex: Int?
    @State private var videoTitle: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Video \(index) Title", text: $videoTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 4)

            HStack {
                Button(action: {
                    currentVideoIndex = index - 1
                    isShowingImagePicker = true
                }) {
                    Text("Select File")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()

                Text(videoURLs.indices.contains(index - 1) && videoURLs[index - 1] != nil ? "File Selected: \(videoURLs[index - 1]!.lastPathComponent)" : "No file selected")
                    .foregroundColor(videoURLs.indices.contains(index - 1) && videoURLs[index - 1] != nil ? .primary : .secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
    }
}
struct VideoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        VideoUploadView()
    }
}
