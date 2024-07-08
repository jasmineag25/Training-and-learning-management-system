import Foundation

struct Course: Identifiable {
    var id: String
    var email : String
    var name: String
    var description: String
    var duration: String
    var language: String
    var price: String
    var category: String
    var keywords: String
    var imageUrl: String
    var videos: [Video]?
    var notes: [Note]?
    
    func todictionary() -> [String : Any] {
        return ["id": id,
              "email" :email,
              "name": name,
              "description": description,
              "duration": duration,
              "language": language,
              "price": price,
              "category": category,
              "keywords": keywords,
              "imageUrl": imageUrl,
              "videos": videos,
              "notes": notes]
    }
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
