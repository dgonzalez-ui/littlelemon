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
        VStack(alignment: .center){
            AsyncImage(url: URL(string: dish.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 250)
            Text(dish.information)
            Text(dish.category)
            Text(dish.price)
            Spacer()
        }.navigationTitle(dish.title)
    }
}

struct DishDetails_Previews: PreviewProvider {
    static var previews: some View {
        DishDetails(dish: Dish())
    }
}
