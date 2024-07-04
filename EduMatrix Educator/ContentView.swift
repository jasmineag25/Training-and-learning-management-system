//
//  ContentView.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 03/07/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Madhav Verma!")
        }
        .padding()
    }
}

func signIn(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        } else {
            print("User signed in successfully")
        }
    }
}

#Preview {
    ContentView()
}
