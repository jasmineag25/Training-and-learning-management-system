//
//  CourseKeywordPickerView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//

import Foundation
import SwiftUI

struct CourseKeywordPicker: View {
    var title: String
    @Binding var selectedKeywords: [String]
    var options: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.top)
            Menu {
                ForEach(options, id: \.self) { keyword in
                    Button(action: {
                        if selectedKeywords.contains(keyword) {
                            selectedKeywords.removeAll { $0 == keyword }
                        } else {
                            selectedKeywords.append(keyword)
                        }
                    }) {
                        HStack {
                            Text(keyword)
                            Spacer()
                            if selectedKeywords.contains(keyword) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedKeywords.isEmpty ? "Select Keywords" : selectedKeywords.joined(separator: ", "))
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(selectedKeywords.isEmpty ? Color.gray.opacity(0.2) : Color.white)
                .cornerRadius(8)
            }
            .padding(.bottom)
        }
    }
}
