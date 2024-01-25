//
//  Utilities.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-25.
//

import SwiftUI

enum AppColors {
    static func rgb(_ red: Double, _ green: Double, _ blue: Double, alpha: Double = 1.0) -> Color {
            return Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, opacity: alpha)
        }
    
    static let primaryOne = rgb(73, 94, 87)
    static let primaryTwo = rgb(244, 206, 20)
    static let secondaryThree = rgb(237, 239, 238)
    static let secondaryFour = rgb(51, 51, 51)
}

struct Utilities: View {
    
    var body: some View {
        EmptyView()
    }
}

struct Utilities_Previews: PreviewProvider {
    static var previews: some View {
        Utilities()
    }
}
