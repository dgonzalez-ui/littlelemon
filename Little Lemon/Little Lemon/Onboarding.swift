//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-17.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"
enum AppColors {
    static func rgb(_ red: Double, _ green: Double, _ blue: Double, alpha: Double = 1.0) -> Color {
            return Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, opacity: alpha)
        }
    
    static let primaryOne = rgb(73, 94, 87)
    static let primaryTwo = rgb(244, 206, 20)
    static let secondaryThree = rgb(237, 239, 238)
    static let secondaryFour = rgb(51, 51, 51)
}

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
                ZStack(alignment:.leading){
                    Rectangle()
                        .fill(AppColors.primaryOne)
                        .frame(width: 428, height: 324)
                    VStack(alignment:.leading){
                        Text("Little Lemon")
                            .foregroundColor(AppColors.primaryTwo)
                            .font(.custom("MarkaziText-Medium", size: 64))
                        Text("Chicago")
                            .foregroundColor(Color.white)
                            .font(.custom("MarkaziText-Regular", size: 40))
                        Spacer()
                    }.padding(EdgeInsets(top: 35, leading: 30, bottom: 25, trailing: 25))
                    VStack{
                        Spacer()
                        HStack{
                            VStack(alignment:.leading){
                                
                                Text("We are a family owned Mediterranean restaurent, focused on traditional recipes served with a modern twist")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Karla-Medium", size: 18))
                               
                            }
                            Image("hero-image")
                                .resizable()
                                .frame(width:140, height:143)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                        }
                    }.padding(EdgeInsets(top: 130, leading: 30, bottom: 30, trailing: 25))
                }
                .frame(width:428, height: 324)
                /*.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 2))*/
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
