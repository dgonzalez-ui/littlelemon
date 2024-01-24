//
//  DishDetails.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-19.
//

import SwiftUI

struct DishDetails: View {
    let dish: Dish
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                ZStack{
                    Rectangle()
                        .fill(AppColors.primaryOne)
                        .frame(width:428, height: 324)
                    AsyncImage(url: URL(string: dish.image)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: 250, height: 250)
                    
                }
                List{
                    Text(dish.title)
                        .foregroundColor(AppColors.secondaryFour)
                        .font(.custom("Karla-ExtraBold", size: 30))
                        .padding(.vertical)
                    VStack(alignment: .leading){
                        Text(dish.category)
                            .foregroundColor(AppColors.primaryOne)
                            .font(.custom("Karla-Bold", size: 20))
                        Text(dish.information)
                            .foregroundColor(AppColors.primaryOne)
                            .font(.custom("Karla-Regular", size: 24))
                            .padding(.vertical)
                        Text("$\(dish.price)")
                            .foregroundColor(AppColors.primaryOne)
                            .font(.custom("Karla-Bold", size: 20))
                    }.padding(20)
                }
            } 
        }
    }
}

struct DishDetails_Previews: PreviewProvider {
    static var previews: some View {
        DishDetails(dish: Dish())
    }
}
