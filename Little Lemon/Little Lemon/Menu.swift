//
//  Menu.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-17.
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

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""

    let rectHeight = 324.0
    
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
        NavigationView{
            NavigationStack{
                VStack{
                    ZStack(alignment:.leading){
                        Rectangle()
                            .fill(AppColors.primaryOne)
                            .frame(width: 428, height: rectHeight)
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
                            HStack{
                                Image(systemName: "magnifyingglass")
                                TextField("Search Menu", text: $searchText)
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .fill(AppColors.secondaryThree)
                            )
                        }.padding(EdgeInsets(top: 130, leading: 30, bottom: 30, trailing: 25))
                        
                    }
                    .frame(width:428, height: rectHeight)
                    
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
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
