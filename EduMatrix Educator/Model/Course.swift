//
//  Course.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//

import Foundation

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var rating: Int
    var price: String
    var imageName: String
}
