import Foundation

struct Course: Identifiable {
    var id: UUID
    var name: String
    var description: String
    var duration: String
    var language: String
    var price: String
    var category: String
    var keywords: [String]
    var imageUrl: URL?
    var videos: [Video]
    var notes: [Note]
}

struct Video: Identifiable {
    var id: UUID
    var title: String
    var url: URL
}

struct Note: Identifiable {
    var id: UUID
    var title: String
    var url: URL
}
