//
//  DishCard.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-25.
//

import SwiftUI

struct DishCard: View {
    var title = "Title"
    var description = "Dish Description"
    var price = "Price"
    var image = ""
    
    var body: some View {
        HStack(alignment:.center){
            VStack(alignment:.leading, spacing: 10){
                Text(title)
                    .foregroundColor(AppColors.secondaryFour)
                    .font(.custom("Karla-Bold", size: 18))
                    .padding(.vertical)
                Text(description)
                    .foregroundColor(AppColors.primaryOne)
                    .font(.custom("Karla-Regular", size: 16))
                    .frame(maxWidth:225, alignment: .leading)
                    .lineLimit(2, reservesSpace: true)
                Text("$\(price)")
                    .foregroundColor(AppColors.primaryOne)
                    .font(.custom("Karla-Medium", size: 16))
            }
            Spacer()
            
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct DishCard_Previews: PreviewProvider {
    static var previews: some View {
        DishCard()
    }
}
