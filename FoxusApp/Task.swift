//
//  Task.swift
//  FoxusApp
//
//  Created by raida on 06/12/2023.
//



import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var doneFlag: Bool
    var date: Date
}
