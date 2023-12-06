//
//  FoxusAppApp.swift
//  FoxusApp
//
//  Created by AlJawharh AlOtaibi on 20/05/1445 AH.
//

import SwiftUI

@main
struct foxus_MC2App: App {
@StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
           // ContentView()
            MainPage()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
