//
//  Menu.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-17.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @State var searchCategory = ""
    
    func dishExists(title: String) -> Bool {
        let fetchRequest = Dish.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let existingDishes = try viewContext.fetch(fetchRequest)
            if (existingDishes.isEmpty) {
                return false
            } else {
                return true
            }
        } catch {
            print("Error checking existence: \(error)")
            return false
        }
    }
    
    func buildPredicate() -> NSPredicate {
        if (!searchCategory.isEmpty && searchText.isEmpty){
            return NSPredicate(format: "category CONTAINS[cd] %@", searchCategory)
        }
        if (searchText.isEmpty) {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    func getMenuData(){
        //PersistenceController.shared.clear()
        
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
                            
                            if (!dishExists(title: item.title)){
                                let dish = Dish(context: viewContext)
                                dish.title = item.title
                                dish.price = item.price
                                dish.information = item.information
                                dish.image = item.image
                                dish.category = item.category
                            }
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
        NavigationView {
            VStack {
                
                HeroCard(showSearch: true, searchText: $searchText)
                CategoryButtons(searchCategory: $searchCategory)
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List{
                        ForEach(dishes){ dish in
                            NavigationLink(destination: DishDetails(dish: dish)) {
                                DishCard(title: dish.title, description: dish.information, price: dish.price, image: dish.image)
                            }
                        }
                    }
                }
            }.onAppear{
                getMenuData()
            }
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



struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
