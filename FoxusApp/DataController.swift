//
//  DataController.swift
//  FoxusApp
//
//  Created by AlJawharh AlOtaibi on 20/05/1445 AH.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "foxus_MC2")
    
    init(){
        container.loadPersistentStores{ description, error in if let  error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
            
            
        }}
        
        
    }
    
    
}
