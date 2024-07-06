//
//  SubmitButton.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//

import Foundation
import SwiftUI

struct SubmitButton: View {
    @Binding var showAlert: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Send Request")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding(.top)
    }
}
