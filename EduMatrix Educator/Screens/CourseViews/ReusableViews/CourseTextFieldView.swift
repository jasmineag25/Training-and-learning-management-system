//
//  CourseTextFieldView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//
import SwiftUI
import Foundation

struct CourseTextField: View {
    var title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.top)
            TextField("Enter \(title.lowercased())", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
                .keyboardType(keyboardType)
        }
    }
}
