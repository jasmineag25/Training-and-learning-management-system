//
//  ProfileView.swift
//  EduMatrix Educator
//
/* Created by Divyanshu rai on 18/07/24.


import SwiftUI
import PhotosUI

//Model to hold user profile data
class UserProfile: ObservableObject {
    @Published var name: String = "Ashish Saxena"
    @Published var email: String = "ashishsaxena@gmail.com"
    @Published var username: String = "ashishsaxena"
    @Published var pronouns: String = "He/His"
    @Published var password: String = "******************"
    @Published var phoneNumber: String = "9876543215"
    @Published var gender: String = "Male"
    @Published var profileImage: UIImage? = UIImage(named: "ios")
}

struct ProfileView: View ,Hashable{
    @StateObject private var userProfile = UserProfile()
    @State private var isImagePickerPresented = false
    @State private var selectedURL: URL?
    func hash(into hasher: inout Hasher) {
           hasher.combine("ProfileView")
       }

       static func == (lhs: ProfileView, rhs: ProfileView) -> Bool {
           true
       }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
    // Profile Image and Name
    VStack(spacing: 8) {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: userProfile.profileImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
                        Text(userProfile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(userProfile.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 30)
    
    // Sections
    VStack(spacing: 16) {
        ProfileSection(title: "Personal Information", iconName: "info.circle", destination: AnyView(PersonalInformationView(userProfile: userProfile)))
        ProfileSection(title: "Forgot Password", iconName: "lock.circle", destination: AnyView(Text("Forgot Password View")))
        ProfileSection(title: "Help & Support", iconName: "questionmark.circle", destination: AnyView(Text("Help & Support View")))
        ProfileSection(title: "Log Out", iconName: "power.circle", destination: AnyView(Text("Log Out View")))
    }
                    .padding(.horizontal)
                    

                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $userProfile.profileImage, selectedURL: $selectedURL, isPresented: $isImagePickerPresented, mediaTypes: ["public.image"])
            }
        }
    }
}

struct ProfileSection: View {
    var title: String
    var iconName: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

struct PersonalInformationView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var isImagePickerPresented = false
    @State private var selectedURL: URL?
    @State private var nameError: String?


    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: userProfile.profileImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .offset(x: -10, y: -10)
                    }
                    
                    TextField("Name", text: $userProfile.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
               isImagePickerPresented = false
           }) {
               Image(systemName: "pencil.circle.fill")
                   .resizable()
                   .frame(width: 24, height: 24)
                   .foregroundColor(.gray)
                   .background(Color.white)
                   .clipShape(Circle())
           }
           .offset(x: -10, y: -10).padding(.leading,245).padding(.top,-42)


                    
                        .onChange(of: userProfile.name) { newValue in
                            validateName()
                        }
                        .onSubmit {
                            validateName()
                        }
                    
                    if let nameError = nameError {
                        Text(nameError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Text("Educator")
                        .font(.subheadline)
                        .foregroundColor(.gray).padding(.top,-25)
                }
                .padding(.top, -70)
                
                FormField(title: "User name", text: $userProfile.username)
                FormField(title: "Pronouns", text: $userProfile.pronouns)
                FormField(title: "Password", text: $userProfile.password, isSecure: true)
                FormField(title: "Phone number", text: $userProfile.phoneNumber)
                FormField(title: "Gender", text: $userProfile.gender)
                
                Spacer()
            }
            .padding()
           // .navigationTitle("Personal Information")
            ImagePicker(selectedImage: $userProfile.profileImage, selectedURL: $selectedURL, isPresented: $isImagePickerPresented, mediaTypes: ["public.image"])
            }
        }
    
    
    private func validateName() {
        if userProfile.name.isEmpty {
            nameError = "Name cannot be empty"
        } else if Double(userProfile.name) != nil {
            nameError = "Name cannot be a number"
        } else if !userProfile.name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = nil
        } else {
            nameError = "Name must contain some characters"
        }
    }
}

struct FormField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }
    }
}
*/
import SwiftUI


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


import SwiftUI
import PhotosUI

// Model to hold user profile data
class UserProfile: ObservableObject {
    @Published var name: String = "Ashish Saxena"
    @Published var email: String = "ashishsaxena@gmail.com"
    @Published var username: String = "ashishsaxena"
    @Published var pronouns: String = "He/His"
    @Published var password: String = "******************"
    @Published var phoneNumber: String = "9876543215"
    @Published var gender: String = "Male"
    @Published var profileImage: UIImage? = UIImage(named: "ios")
}

struct ProfileView: View {
    @StateObject private var userProfile = UserProfile()
    @State private var isImagePickerPresented = false
    @State private var selectedURL: URL?

    var body: some View {
       
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Image and Name
                    VStack(spacing: 8) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: userProfile.profileImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                            
                            
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.gray)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            
                            .offset(x: -10, y: -10)
                        }
                        Text(userProfile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(userProfile.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 30)
                    
                    // Sections
                    VStack(spacing: 16) {
                        ProfileSection(title: "Personal Information", iconName: "info.circle", destination: AnyView(PersonalInformationView(userProfile: userProfile)))
                        ProfileSection(title: "Forgot Password", iconName: "lock.circle", destination: AnyView(Text("Forgot Password View")))
                        ProfileSection(title: "Help & Support", iconName: "questionmark.circle", destination: AnyView(Text("Help & Support View")))
                        ProfileSection(title: "Log Out", iconName: "power.circle", destination: AnyView(Text("Log Out View")))
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $userProfile.profileImage, selectedURL: $selectedURL, isPresented: $isImagePickerPresented, mediaTypes: ["public.image"])
            }
        }
    }


struct ProfileSection: View {
    var title: String
    var iconName: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

struct PersonalInformationView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var isImagePickerPresented = false
    @State private var selectedURL: URL?
    @State private var nameError: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: userProfile.profileImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .offset(x: -10, y: -10)
                    }
                    
                    TextField("Name", text: $userProfile.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .onChange(of: userProfile.name) {
                            validateName()
                        }

                        .onSubmit {
                            validateName()
                        }
                    
                    if let nameError = nameError {
                        Text(nameError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Text("Educator")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, -25)
                }
                .padding(.top, -70)
                
                FormField(title: "User name", text: $userProfile.username)
                FormField(title: "Pronouns", text: $userProfile.pronouns)
                FormField(title: "Password", text: $userProfile.password, isSecure: true)
                FormField(title: "Phone number", text: $userProfile.phoneNumber)
                FormField(title: "Gender", text: $userProfile.gender)
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $userProfile.profileImage, selectedURL: $selectedURL, isPresented: $isImagePickerPresented, mediaTypes: ["public.image"])
            }
        }.navigationBarItems(trailing: Button("Edit") {
            // Edit action
            })
    }
        
    private func validateName() {
        if userProfile.name.isEmpty {
            nameError = "Name cannot be empty"
        } else if Double(userProfile.name) != nil {
            nameError = "Name cannot be a number"
        } else if !userProfile.name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = nil
        } else {
            nameError = "Name must contain some characters"
        }
    }
}

struct FormField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedURL: URL?
    @Binding var isPresented: Bool
    var mediaTypes: [String]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            if let url = info[.imageURL] as? URL {
                parent.selectedURL = url
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
//

