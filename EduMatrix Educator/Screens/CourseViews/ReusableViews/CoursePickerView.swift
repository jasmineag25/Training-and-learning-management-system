//
//  CoursePickerView.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//

import Foundation
import SwiftUI

struct CoursePicker: View {
    var title: String
    @Binding var selection: String
    var options: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.top)
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selection)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(selection == "Select Language" ? Color.gray.opacity(0.2) : Color.white)
                .cornerRadius(8)
            }
            .padding(.bottom)
        }
    }
}
