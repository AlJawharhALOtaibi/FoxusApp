//
//  FoxusAppApp.swift
//  FoxusApp
//
//  Created by AlJawharh AlOtaibi on 20/05/1445 AH.
//

import SwiftUI

@main
struct FoxusAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
