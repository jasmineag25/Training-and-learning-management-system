//
//  Services.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 06/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import SwiftUI

func submitEducatorRequest(firstName : String, middleName : String, lastName : String, aadharImage: UIImage, profileImage: UIImage, email: String, mobileNumber: String , qualification: String, experience : String, subjectDomain: [String], language : [String], about : String, completion: @escaping (Bool) -> Void) {
    guard let aadharImageData = aadharImage.jpegData(compressionQuality: 0.75), let profileImageData = profileImage.jpegData(compressionQuality: 0.75) else {
        completion(false)
        return
    }
    
//    let postID = UUID().uuidString
    let storageRef = Storage.storage().reference().child("educatorsImagesURL").child(email)
    
    storageRef.child("aadharImageURL").putData(aadharImageData) { metadata, error in
        if let error = error {
            print("Failed to upload image: \(error.localizedDescription)")
            completion(false)
            return
        }

        storageRef.child("aadharImageURL").downloadURL { url, error in
            guard let aadharImageURL = url?.absoluteString else {
                completion(false)
                return
            }
            
            storageRef.child("profileImageURL").putData(profileImageData) { metadata1, error in
                if let error = error {
                    print("Failed to upload image: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                storageRef.child("profileImageURL").downloadURL { url1, error in
                    guard let profileImageURL = url1?.absoluteString else {
                        completion(false)
                        return
                    }
                    let db = Firestore.firestore()
                    let userData: [String: Any] = [
                        "firstName": firstName,
                        "middleName": middleName,
                        "lastName": lastName,
                        "fullName" : firstName + " " + middleName + " " + lastName,
                        "email": email,
                        "mobileNumber": mobileNumber,
                        "qualification": qualification,
                        "experience": experience,
                        "subjectDomain": subjectDomain,
                        "language": language,
                        "about" : about,
                        "aadharImageURL" : aadharImageURL,
                        "profileImageURL" : profileImageURL
                    ]
                    db.collection("educatorsRequests").document(email).setData(userData) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            completion(true)
                            print("Document added successfully")
                        }
                    }
                }
            }
        }
    }
}

func fetchMyCourses(completion: @escaping ([Course]) -> Void) {
        let db = Firestore.firestore()
        var courses: [Course] = []
        let dispatchGroup = DispatchGroup()

        db.collection("educators").document(email).getDocument { document, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            if let document = document, document.exists {
                if let enrolledCourses = document.get("courses") as? [String] {
                    for courseId in enrolledCourses {
                        dispatchGroup.enter()
                        db.collection("courses").document(courseId).getDocument { snapshot, error in
                            defer { dispatchGroup.leave() }
                            if let error = error {
                                print("Error fetching course document: \(error)")
                                return
                            }
                            guard let docum = snapshot, let data = docum.data() else {
                                print("No course document found")
                                return
                            }
                            
                            // Decode videos
                            var videos = [Video]()
                            if let videosData = data["videos"] as? [[String: Any]] {
                                videos = videosData.compactMap { videoData in
                                    guard let idString = videoData["id"] as? String,
                                          let id = UUID(uuidString: idString),
                                          let title = videoData["title"] as? String,
                                          let urlString = videoData["videoURL"] as? String,
                                          let url = URL(string: urlString) else {
                                        return nil
                                    }
                                    return Video(id: id, title: title, videoURL: url)
                                }
                            }
                            
                            // Create the course object
                            let course = Course(
                                id: data["id"] as? String ?? "",
                                educatorEmail: data["educatorEmail"] as? String ?? "",
                                educatorName: data["educatorName"] as? String ?? "",
                                name: data["name"] as? String ?? "",
                                description: data["description"] as? String ?? "",
                                duration: data["duration"] as? String ?? "",
                                language: data["language"] as? String ?? "",
                                price: data["price"] as? String ?? "",
                                category: data["category"] as? String ?? "",
                                averageRating: data["averageRating"] as? Double ?? 0.0, 
                                keywords: data["keywords"] as? String ?? "",
                                imageUrl: data["imageUrl"] as? String ?? "",
                                videos: videos,
                                notes: nil
                            )
                            courses.append(course)
                        }
                    }

                    // Wait for all tasks to complete
                    dispatchGroup.notify(queue: .main) {
                        completion(courses)
                    }
                } else {
                    print("No enrolled courses found")
                    completion([])
                }
            } else {
                print("Document does not exist")
                completion([])
            }
        }
    }

func submitCourseRequest(name: String, description: String, duration: String, price: String, category: String, keywords: String, image: UIImage, language: String, email: String, educatorName : String, videos: [Video], completion: @escaping (Bool) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.75) else {
        completion(false)
        return
    }
    
    var newVideos = [Video]()
    
    let courseID = UUID().uuidString
    let storageRef = Storage.storage().reference().child("courseImagesLink").child(email).child(courseID)
    
    storageRef.putData(imageData) { metadata, error in
        if let error = error {
            print("Failed to upload image: \(error.localizedDescription)")
            completion(false)
            return
        }
        storageRef.downloadURL { url, error in
            guard let imageURL = url?.absoluteString else {
                completion(false)
                return
            }
            
            let storageRef1 = Storage.storage().reference().child("courseVideos")
            let dispatchGroup = DispatchGroup()
            
            for video in videos {
                print(video)
                dispatchGroup.enter()
                let videoRef = storageRef1.child(video.id.uuidString)
                videoRef.putFile(from: video.videoURL, metadata: nil) { metadata, error in
                    if let error = error {
                        print("Error uploading video: \(error.localizedDescription)")
                        dispatchGroup.leave()
                        return
                    }
                    videoRef.downloadURL { url1, error in
                        if let error = error {
                            print("Error fetching download URL: \(error.localizedDescription)")
                            dispatchGroup.leave()
                            return
                        }
                        if let videoURL = url1?.absoluteString {
                            newVideos.append(Video(id: video.id, title: video.title, videoURL: URL(string: videoURL)!))
                        }
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                let courseData = Course(id: courseID, educatorEmail: email, educatorName: educatorName, name: name, description: description, duration: duration, language: language, price: price, category: category, keywords: keywords, imageUrl: imageURL, videos: newVideos, notes: nil)
                let db = Firestore.firestore()
                
                db.collection("coursesRequests").document(courseData.id).setData(courseData.toDictionary()) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        completion(false)
                    } else {
                        print("Course added successfully")
                        completion(true)

                    }
                }
            }
        }
    }
}

func fetchListOfCourses(completion: @escaping ([Course]) -> Void) {
    var courses : [Course] = []
    let db = Firestore.firestore()
    db.collection("courses").getDocuments { snapshot, error in
        if let error = error {
            print("Error fetching documents: \(error)")
            return
        }
        guard let documents = snapshot?.documents else {
            print("No documents")
            return
        }
        courses = documents.compactMap { doc in
            let data = doc.data()
            
            // Decode videos
            var videos = [Video]()
            if let videosData = data["videos"] as? [[String: Any]] {
                videos = videosData.compactMap { videoData in
                    return Video(id: UUID(uuidString: videoData["id"] as! String)!, title: videoData["title"] as? String ?? "", videoURL: URL(string: videoData["videoURL"] as? String ?? "")!)
                }
            }
            
            // Create the course object
            return Course(
                id: data["id"] as? String ?? "",
                educatorEmail: data["educatorEmail"] as? String ?? "",
                educatorName: data["educatorName"] as? String ?? "",
                name: data["name"] as? String ?? "",
                description: data["description"] as? String ?? "",
                duration: data["duration"] as? String ?? "",
                language: data["language"] as? String ?? "",
                price: data["price"] as? String ?? "",
                category: data["category"] as? String ?? "",
                averageRating: data["averageRating"] as? Double ?? 0.0,
                keywords: data["keywords"] as? String ?? "",
                imageUrl: data["imageUrl"] as? String ?? "",
                videos: videos,
                notes: nil
            )
        }
        completion(courses)
    }
}

func fetchListOfMyCourses(completion: @escaping ([Course]) -> Void) {
    var courses : [Course] = []
    let db = Firestore.firestore()
    db.collection("courses").getDocuments { snapshot, error in
        if let error = error {
            print("Error fetching documents: \(error)")
            return
        }
        guard let documents = snapshot?.documents else {
            print("No documents")
            return
        }
        courses = documents.compactMap { doc in
            let data = doc.data()
            
            // Decode videos
            var videos = [Video]()
            if let videosData = data["videos"] as? [[String: Any]] {
                videos = videosData.compactMap { videoData in
                    return Video(id: UUID(uuidString: videoData["id"] as! String)!, title: videoData["title"] as? String ?? "", videoURL: URL(string: videoData["videoURL"] as? String ?? "")!)
                }
            }
            
            // Create the course object
            return Course(
                id: data["id"] as? String ?? "",
                educatorEmail: data["educatorEmail"] as? String ?? "",
                educatorName: data["educatorName"] as? String ?? "",
                name: data["name"] as? String ?? "",
                description: data["description"] as? String ?? "",
                duration: data["duration"] as? String ?? "",
                language: data["language"] as? String ?? "",
                price: data["price"] as? String ?? "",
                category: data["category"] as? String ?? "",
                averageRating: data["averageRating"] as? Double ?? 0.0,
                keywords: data["keywords"] as? String ?? "",
                imageUrl: data["imageUrl"] as? String ?? "",
                videos: videos,
                notes: nil
            )
        }
        completion(courses)
    }
}

let db = Firestore.firestore()
let email : String = (Auth.auth().currentUser?.email)!
