//
//  VideoPicker.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.


import Foundation
import SwiftUI

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var videos: [Video]
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool
//    var name : String
    var mediaTypes: [String] = ["public.movie"]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                let video = Video(id: UUID(), title: "Enter Lecture Title" , videoURL: url)
                parent.videos.append(video)
                parent.selectedURL = url
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

