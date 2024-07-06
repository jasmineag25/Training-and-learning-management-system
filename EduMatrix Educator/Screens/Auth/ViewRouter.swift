//
//  ViewRouter.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 06/07/24.
//
import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .signPage
}

enum Page {
    case signPage
    case homePage
}
