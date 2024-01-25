//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-17.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"


struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(destination:Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                HeroCard()
                
                VStack(alignment:.leading){
                    TextField("First Name*", text: $firstName)
                    TextField("Last Name*", text: $lastName)
                    TextField("E-Mail*", text: $email)
                }.padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 25))
                    .textFieldStyle(.roundedBorder)
                Button("Register"){
                    if( firstName.isEmpty == false && lastName.isEmpty == false &&
                        email.isEmpty == false){
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        isLoggedIn = true
                        UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(AppColors.secondaryFour)
                .background(AppColors.primaryTwo)
                .cornerRadius(10)
                Spacer()
            }.onAppear{
                if (UserDefaults.standard.bool(forKey: kIsLoggedIn) == true){
                    isLoggedIn = true
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Image("header-logo")
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
