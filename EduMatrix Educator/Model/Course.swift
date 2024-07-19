import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit
import SwiftUI

struct Course: Identifiable , Codable{ // Ensure Course conforms to Identifiable
    var id: String
    var educatorEmail : String
    var educatorName: String
    var name: String
    var description: String
    var duration: String
    var language: String
    var price: String
    var category: String
    var averageRating: Double = 0.0
    var keywords: String
    var imageUrl: String
    var videos: [Video]
    var notes: [Note]?
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "email": educatorEmail,
            "educatorName" : educatorName,
            "name": name,
            "description": description,
            "duration": duration,
            "language": language,
            "price": price,
            "category": category,
            "averageRating" : averageRating,
            "keywords": keywords,
            "imageUrl": imageUrl,
            "videos": videos.map { $0.toDictionary() },
            "notes": notes
        ]
    }
}
struct Video: Identifiable ,Codable{
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

struct Note: Identifiable , Codable {
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
//struct Course: Identifiable {
//    let id = UUID()
//    let name: String
//    let description: String
//    let keywords: [String]
//    let price: String
//    let ratings: Double
//    
//    let duration: Double
//    let imageUrl: Image
//    let videos: [Video]
//    let notes: [Note]
//    let assignments: [Assignment]
//}
struct eduactorTotalData{
    var totalEnrollemnts:Int=320
    var totalCousrses:Int
    
}


struct Module: Identifiable {
    let id = UUID()
    let title: String
    let videoName: URL?
}

struct Assignment: Identifiable {
    let id = UUID()
    let title: String
    let pdfName:URL?
}

