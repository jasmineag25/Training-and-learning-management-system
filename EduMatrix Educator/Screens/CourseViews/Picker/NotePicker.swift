//
//  NotePicker.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//
import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct NotePicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool
    var mediaTypes: [String] = ["public.text", "public.pdf"]

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: mediaTypes.map { UTType($0) ?? UTType.text }, asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: NotePicker

        init(_ parent: NotePicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.selectedURL = urls.first
            parent.isPresented = false
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.isPresented = false
        }
    }
}


