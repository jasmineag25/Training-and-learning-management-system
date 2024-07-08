//
//  CourseImagePicker.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//

import Foundation
import SwiftUI

struct CourseImagePicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var isShowingImagePicker: Bool

    var body: some View {
        VStack(alignment: .leading) {
//            Text("Image")
//                .font(.headline)
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(maxWidth:.infinity, maxHeight: 200)
                        .clipped()
                        .cornerRadius(8)
                } else {
                    Text("No file selected")
                }
                Spacer()
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("Upload")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom)
        }
    }
}

