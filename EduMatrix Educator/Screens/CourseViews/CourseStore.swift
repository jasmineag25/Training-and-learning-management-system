import SwiftUI
import Combine

class CourseStore: ObservableObject {
    @Published var courses: [Course] = [
        Course(title: "Fronted Web Development", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course1")
    ]
}
