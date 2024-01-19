//
//  Menu.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-17.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    func getMenuData(){
        PersistenceController.shared.clear()
        
        let url =  URL(string:"https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data, error == nil else {
                return
            }
            
            //convert to json
            do {
                let decodedMenu = try JSONDecoder().decode([String: [MenuItem]].self, from: data)
                if let menu = decodedMenu["menu"] {
                    DispatchQueue.main.async {
                        menu.forEach { item in
                            let dish = Dish(context: viewContext)
                            dish.title = item.title
                            dish.price = item.price
                            dish.information = item.information
                            dish.image = item.image
                            dish.category = item.category
                        }
                        try? viewContext.save()
                        
                    }
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("Short Description")
            FetchedObjects() { (dishes: [Dish]) in
                List{
                    ForEach(dishes){ dish in
                        NavigationLink(destination: DishDetails(dish: dish)) {
                            HStack{
                                Text("\(dish.title)  \(dish.price)")
                                Spacer()
                                AsyncImage(url: URL(string: dish.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50, alignment: .trailing)
                            }
                        }
                    }
                }
            }
        }.onAppear{
            getMenuData()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
