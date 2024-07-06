import Combine

class CourseStore: ObservableObject {
    @Published var courses: [Course] = []
}

