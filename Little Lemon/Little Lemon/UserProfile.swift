//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-17.
//

import SwiftUI

struct ProfileInfoForm: View {
    let firstName = UserDefaults.standard.string(forKey: "kFirstName")
    let lastName = UserDefaults.standard.string(forKey: "kLastName")
    let email = UserDefaults.standard.string(forKey: "kEmail")

    var body: some View{
        
        VStack(alignment:.leading, spacing:16){
            LabeledText(label: "First Name", value: firstName)
            LabeledText(label: "Last Name", value: lastName)
            LabeledText(label: "Email", value: email)
        }.padding(.vertical)
    }
    
}

struct LabeledText: View{
    var label: String
    var value: String?
    
    var body: some View {
        VStack(alignment:.leading, spacing:5){
            Text(label)
                .font(.title3)
            Text(value ?? "default")
                .font(.title2)
                .multilineTextAlignment(.center).padding()
                .frame(width: UIScreen.main.bounds.width - 60, height:50, alignment: .leading)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray))
        }
    }
}

    
struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Text("Personal Information")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding()
                Text("Avatar")
                    .font(.title3)
                Image("profile-image")
                    .resizable()
                    .frame(width:100, height:100)
                
                ProfileInfoForm()
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            .buttonStyle(.bordered)
            .foregroundColor(AppColors.secondaryFour)
            .background(AppColors.primaryTwo)
            .cornerRadius(10)
            Spacer()
            
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Image("header-logo")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("profile-image")
                        .resizable()
                        .frame(width:50, height: 50)
                }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
