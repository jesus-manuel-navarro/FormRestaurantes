//
//  SwiftUIFormApp.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI
import FirebaseCore




class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    //FirebaseApp.configure()


    return true
  }
}


struct SwiftUIFormApp: App {
    var almacenInicial = SettingStore()
    
    // para entrar en Firebase nada mas ya no se vuelve  ausar
    var nico = FirrebaseApp.configure()
    // Crear una instancia de RestaurantViewModel y pasarle el almacen
    let viewModel = RestaurantViewModel(almacen: SettingStore())
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel).environmentObject(almacenInicial)
        }
    }
}
