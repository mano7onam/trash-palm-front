//
//  clientAppApp.swift
//  clientApp
//
//  Created by Stanislav Zelikson on 25/11/2023.
//
//

import SwiftUI

@main
struct clientAppApp: App {
    @StateObject var userAuth: AppState =  AppState()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }.environmentObject(userAuth)
    }
}
