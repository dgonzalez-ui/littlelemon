//
//  HeroCard.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-25.
//

import SwiftUI

struct HeroCard: View {
    let rectWidth = 428.0
    let rectHeight = 324.0
    var showSearch = false
  
    var searchText: Binding<String>? = nil
    
    var body: some View {
        ZStack(alignment:.leading){
            Rectangle()
                .fill(AppColors.primaryOne)
                .frame(width: rectWidth, height: rectHeight)
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
                if (showSearch) {
                    HStack{
                        Image(systemName: "magnifyingglass")
                        if let searchText = searchText{
                            TextField("Search Menu", text: searchText)
                        }
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(AppColors.secondaryThree)
                    )
                }
            }.padding(EdgeInsets(top: 130, leading: 30, bottom: 30, trailing: 25))
            
        }
        .frame(width:rectWidth, height: rectHeight)
    }
}

struct HeroCard_Previews_2: View {
    @State private var search = ""
    var body: some View {
        HeroCard(showSearch: true, searchText: $search)
    }
}
    
struct HeroCard_Previews: PreviewProvider {
    static var previews: some View {
        HeroCard_Previews_2()
    }
}
