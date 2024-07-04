import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var rating: Int
    var price: String
    var imageName: String
}

struct ContentsView : View {
    let courses = [
        Course(title: "Fronted Web Development", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course1"),
        Course(title: "Fronted Web Development", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course2"),
        Course(title: "Full Stack Development", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course1"),
        Course(title: "Go Full Stack", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course1"),
        Course(title: "Fronted Web Development", author: "Prakash Sharma", rating: 4, price: "$259", imageName: "course2")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My Courses")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                List(courses) { course in
                    CourseRow(course: course)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarItems(trailing: Button(action: {
                // Add new course action
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

struct CourseRow: View {
    var course: Course
    
    var body: some View {
        HStack {
            Image(course.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.headline)
                Text(course.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < course.rating ? "star.fill" : "star")
                            .foregroundColor(.orange)
                    }
                }
            }
            Spacer()
            Text(course.price)
                .font(.headline)
        }
        .padding(.vertical, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
    }
}
