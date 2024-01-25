//
//  CategoryButtons.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-25.
//

import SwiftUI

struct CategoryButtons: View{
    @State var showStarters = false
    @State var showMains = false
    @State var showDesserts = false
    @State var showDrinks = false
    
    @Binding var searchCategory: String
    
    func checkCategories(){
        if (!showStarters && !showMains && !showDesserts && !showDrinks){
            searchCategory = ""
        }
    }
    
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("ORDER FOR DELIVERY!")
                    .font(.custom("Karla-ExtraBold", size: 20))
                Image("delivery-van")
                    .resizable()
                    .frame(width:60, height: 30)
                Spacer()
            }.padding()
            HStack(spacing: 20){
                Toggle("Starters", isOn: $showStarters)
                    .onChange(of: showStarters) { newValue in
                        if (showStarters) {
                            showMains = false
                            showDesserts = false
                            showDrinks = false
                            searchCategory = "starters"
                        } else {
                            checkCategories()
                        }
                    }.toggleStyle(.button).tint(AppColors.primaryOne)
                    .background(AppColors.secondaryThree)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Toggle("Mains", isOn: $showMains)
                    .onChange(of: showMains) { newValue in
                        if (showMains) {
                            showStarters = false
                            showDesserts = false
                            showDrinks = false
                            searchCategory = "mains"
                        } else {
                            checkCategories()
                        }
                    }.toggleStyle(.button).tint(AppColors.primaryOne)
                    .background(AppColors.secondaryThree)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Toggle("Desserts", isOn: $showDesserts)
                    .onChange(of: showDesserts) { newValue in
                        if (showDesserts) {
                            showStarters = false
                            showMains = false
                            showDrinks = false
                            searchCategory = "desserts"
                        } else {
                            checkCategories()
                        }
                    }.toggleStyle(.button).tint(AppColors.primaryOne)
                    .background(AppColors.secondaryThree)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Toggle("Drinks", isOn: $showDrinks)
                    .onChange(of: showDrinks) { newValue in
                        if (showDrinks) {
                            showStarters = false
                            showMains = false
                            showDesserts = false
                            searchCategory = "drinks"
                        } else {
                            checkCategories()
                        }
                    }.toggleStyle(.button).tint(AppColors.primaryOne)
                    .background(AppColors.secondaryThree)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }.padding()
        }
    }
    
}
struct CategoryButtons_Previews_2: View {
    @State private var category = "starters"
    var body: some View {
        CategoryButtons(searchCategory: $category)
    }
}

struct CategoryButtons_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtons_Previews_2()
    }
}
