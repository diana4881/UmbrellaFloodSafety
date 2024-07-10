//
//  EditProfileViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileViewViewModel: ObservableObject {
    
    var storageManager = StorageManager.shared
    var firebaseManager = FirebaseManager.shared
    @Published var uploadStatus: String = ""
    @Published var username: String = ""
    @Published var name: String
    @Published var password: String
    
    let db = Firestore.firestore()
    
    init() {
        self.name = ""
        self.password = ""
        getUsername()
    }
    
    private func getUsername() {
        self.username = FirebaseManager.shared.currentUserUsername
    }
    
    func saveChanges() {
        
        if !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            resetName()
        }
        
        if !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            resetPassword()
        }
    }
    
    private func resetName() {
        guard !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return }
        
        db.collection("users").document("\(self.username)").updateData(["name": self.name])
    }
    
    private func resetPassword() {
        guard !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        
        guard self.password.count >= 6 else {return }
        
        Auth.auth().currentUser?.updatePassword(to: self.password) { error in
            if let error = error {
                print("An error occured: \(error)")
                return
            } else {
                print("Succesfully updated password")
                return
            }
        }
    }
    
    func uploadImageIntoStorage(data: Data) {
        guard self.username != "" else {
            print("Username is empty")
            return
        }
        let storageRef = Storage.storage().reference().child("users/\(username).jpg")
        storageRef.putData(data, metadata: nil) { metadata, error in
            if let error = error {
                self.uploadStatus = "Error uploading image: \(error.localizedDescription)"
                return
            }
            self.uploadStatus = "Image uploaded successfully"
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error retrieving download pfp URL: \(error.localizedDescription)")
                } else if let url = url {
                    DispatchQueue.main.async {
                        self.storageManager.ProfileImageURL = url.absoluteString
                        print("Successfully obtained pfp URL: \( String(describing: self.storageManager.ProfileImageURL))")
                        
                    }
                }
            }
        }
    }
}