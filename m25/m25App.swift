//
//  m25App.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.13.
//

import SwiftUI

@main
struct m25App: App {
    @StateObject private var appData = AppDataManager.shared
    @StateObject private var productManager = ProductManager.shared
    var body: some Scene {
        WindowGroup {
            GridView().environmentObject(appData)
        }
    }
}
