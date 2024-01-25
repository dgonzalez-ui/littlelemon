//
//  Home.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-17.
//

import SwiftUI

struct Home: View {
    let persistenceController = PersistenceController.shared
        
    var body: some View {
        TabView{
            Menu().tabItem({Label("Menu", systemImage: "list.dash")})
            
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            UserProfile().tabItem({Label("Profile", systemImage: "square.and.pencil")})
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
