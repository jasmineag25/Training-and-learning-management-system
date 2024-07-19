//
//  CourseImagePicker.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//

import Foundation
import SwiftUI


import SwiftUI
import UIKit

struct CourseImagePicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var isShowingImagePicker: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Course Thumbnail").font(.headline)
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight:200, maxHeight: 200)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Text("Upload your thumbnail")
                        .frame(maxWidth: .infinity, minHeight:200, maxHeight: 200)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .onTapGesture {
                isShowingImagePicker = true
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage, selectedURL: .constant(nil), isPresented: $isShowingImagePicker, mediaTypes: ["public.image"])
        }
    }
}

struct CourseImagePicker_Previews: PreviewProvider {
    @State static var selectedImage: UIImage? = nil
    @State static var isShowingImagePicker = false

    static var previews: some View {
        CourseImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

