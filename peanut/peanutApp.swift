//
//  peanutApp.swift
//  peanut
//
//  Created by Ekim Kael on 28/09/2021.
//

import SwiftUI

@main
struct peanutApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
