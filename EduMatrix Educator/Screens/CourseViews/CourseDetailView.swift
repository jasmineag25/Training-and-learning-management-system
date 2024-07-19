//
//  CourseDetailView.swift
//  EduMatrix Educator
//
//  Created by Divyanshu rai on 18/07/24.
//

import Foundation
import SwiftUI
import AVKit
import PDFKit

struct CourseDetailView: View {
    var course: CourseHomeTab

    var body: some View {
ScrollView {
VStack(alignment: .leading) {
course.image
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(height: 200)

VStack(alignment: .leading, spacing: 10) {
    Text(course.name)
        .padding(.top,20)
        .font(.title2)
        .fontWeight(.bold)

    HStack(spacing: 4) {
        ForEach(0..<Int(course.ratings), id: \.self)  { _ in
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
        if course.ratings < 5 {
            ForEach(0..<Int(course.ratings), id: \.self)  { _ in
                Image(systemName: "star")
                    .foregroundColor(.gray)
            }
        }
        Text("\(course.ratings, specifier: "%.1f")/5.0")
    }

    HStack {
        Image(systemName: "clock")
        Text("\(course.duration, specifier: "%.1f") hours")
        Spacer()
        Text("Rs \(course.price)")
    }

    HStack {
        Image(systemName: "doc.text")
        Text("\(course.modules.count) lessons")
    }
Spacer()
    Text("Course Description:")
        .font(.title3).bold()

    Text(course.description)
  
        NavigationLink(destination: ModulesView(modules: course.modules)) {
            HStack {
                Text("Modules") .foregroundColor(.black)
                    .font(.title3).bold()
                    
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical)

        NavigationLink(destination: NotesView(notes: course.notes)) {
            HStack {
                Text("Notes") .foregroundColor(.black)
                    .font(.title3).bold()
                    
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
//                        .padding(.vertical)

        NavigationLink(destination: AssignmentsView(assignments: course.assignments)) {
            HStack {
                Text("Assignments")
                    .foregroundColor(.black)
                    .font(.title3).bold()
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical)
                }

            }
            .padding()
        
    }
    .navigationTitle("Course Details")
    .navigationBarItems(trailing: Button("Edit") {
        // Edit action
        })
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: CourseHomeTab(
            name: "Sample Course",
            description: "This is a sample course.",
            keywords: ["Swift", "iOS"],
            price: "5000",
            ratings: 4.5,
            duration: 12.0, // Assuming duration is a Double
            image: Image("ios"), // Assuming image is an Image
//            modules: [Module(id: UUID(), videoName:  URL(string: "sample1_video_url")!), title: "Sample Module", )],
            modules: [Module(title:"Sample Module", videoName: URL(string: "sample1")!),
                      Module(title:"Sample Module", videoName: URL(string: "sample1")!)],
            notes: [Note(id:UUID(),title: "Sample Note", url: URL(string: "pdf1")!)],
            assignments: [Assignment( title: "Sample Assignment", pdfName: URL(string: "https://example.com/pdf2"))]
        ))
    }
}



struct PDFViewerView: View {
    let url: URL?

    var body: some View {
        if let url = url, let document = PDFDocument(url: url) {
            PDFKitView(document: document)
                .edgesIgnoringSafeArea(.all)
        } else {
            Text("Unable to load PDF.")
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let document: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the view
    }
}

struct VideoPlayerView: View {
    let url: URL?

    var body: some View {
        if let url = url {
            VideoPlayer(player: AVPlayer(url: url))
                .edgesIgnoringSafeArea(.all)
        } else {
            Text("Unable to load video.")
        }
    }
}
struct ModulesView: View {
    var modules: [Module]

    var body: some View {
        List(modules) { module in
            NavigationLink(destination: VideoPlayerView(url: module.videoName)) {
                HStack {
                    Text(module.title)
                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Modules")
    }
}

struct NotesView: View {
    var notes: [Note]

    var body: some View {
        List(notes) { note in
            NavigationLink(destination: PDFViewerView(url: note.url)) {
                HStack {
                    Text(note.title)
                    Spacer()
               }
            }
        }
        .navigationTitle("Notes")
    }
}


