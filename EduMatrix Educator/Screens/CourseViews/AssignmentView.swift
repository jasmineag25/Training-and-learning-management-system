//
//  AssignmentView.swift
//  EduMatrix Educator
//
//  Created by Divyanshu rai on 18/07/24.
//
import SwiftUI
struct AssignmentsView: View {
    var assignments: [Assignment]

    var body: some View {
        List(assignments) { assignment in
            NavigationLink(destination: PDFViewerView(url: assignment.pdfName)) {
                HStack {
                    Text(assignment.title)
                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Assignments")
    }
}

