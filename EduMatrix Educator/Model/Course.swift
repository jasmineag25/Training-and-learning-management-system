import Foundation
import FirebaseAuth
import FirebaseFirestore


struct Course: Identifiable {
    var id: String
    var educatorEmail: String
    var educatorName: String
    var name: String
    var description: String
    var duration: String
    var language: String
    var price: String
    var category: String
    var keywords: String
    var imageUrl: String
    var videos: [Video]
    var notes: [Note]?
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "educatorEmail": educatorEmail,
            "educatorName" : educatorName,
            "name": name,
            "description": description,
            "duration": duration,
            "language": language,
            "price": price,
            "category": category,
            "keywords": keywords,
            "imageUrl": imageUrl,
            "videos": videos.map { $0.toDictionary() },
            "notes": notes
        ]
    }
}

struct Video: Identifiable {
    var id: UUID
    var title: String
    var videoURL: URL
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "videoURL": videoURL.absoluteString
        ]
    }
}

struct Note: Identifiable {
    var id: UUID
    var title: String
    var url: URL
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "url": url.absoluteString
        ]
    }
}
