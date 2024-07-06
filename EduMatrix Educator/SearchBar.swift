//
//  SearchBar.swift
//  EduMatrix Educator
//
//  Created by Shahiyan Khan on 05/07/24.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            Button(action: {
                // Action for search button
            }) {
                Image(systemName: "magnifyingglass")
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
        .padding(.vertical)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
