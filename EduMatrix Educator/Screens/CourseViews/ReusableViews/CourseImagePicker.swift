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
            Text("Course Image")
                .font(.headline)
            HStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
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
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom)
        }
    }
}

