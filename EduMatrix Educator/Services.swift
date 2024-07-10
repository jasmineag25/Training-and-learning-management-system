//
//  Services.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 06/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

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
                        "email": email,
                        "mobileNumber": mobileNumber,
                        "qualification": qualification,
                        "experience": experience,
                        "subjectDomain": subjectDomain,
                        "language": language,
                        "about" : about,
                        "aadharLink" : aadharImageURL,
                        "profileImage" : profileImageURL
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

func submitCourseRequest(name: String, description: String, duration: String, price: String, category: String, keywords: String, image: UIImage, language : String, email : String, completion: @escaping (Bool) -> Void){
    guard let imageData = image.jpegData(compressionQuality: 0.75) else {
        completion(false)
        return
    }
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
            let courseData : Course = Course(id: courseID, email : email, name: name, description: description, duration: duration, language: language, price: price, category: category, keywords: keywords, imageUrl: imageURL)
            let db = Firestore.firestore()
            db.collection("coursesRequests").document(courseData.id).setData(courseData.todictionary()) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    completion(true)
                    print("Course added successfully")
                }
            }
        }
    }
}
