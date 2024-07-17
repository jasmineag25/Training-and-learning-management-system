//
//  Services.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 06/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
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
                let courseData = Course(id: courseID, educatorEmail: email, educatorName: educatorName, name: name, description: description, duration: duration, language: language, price: price, category: category, keywords: keywords, imageUrl: imageURL, videos: newVideos)
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
