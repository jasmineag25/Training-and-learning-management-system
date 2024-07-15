////
////  VideoPicker.swift
////  Learn SwiftUI
////
////  Created by Madhav Verma on 11/07/24.
////
//
//import SwiftUI
//import UIKit
//import AVFoundation
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
