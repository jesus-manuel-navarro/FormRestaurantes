//
//  ContentView.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    
    //@State private var selectedRestaurant: Restaurant?
    //@State private var showSettings: Bool = false
    //@EnvironmentObject var almacen: SettingStore
    
    @StateObject var viewModel: RestaurantViewModel
    
    var body: some View {
        NavigationView {
            List {
                //Ahora llamamos a los restaurantes a través del ViewModel
                ForEach(viewModel.restaurants.sorted(by: viewModel.almacen.displayOrder.predicate())){ restaurant in
                
                //ForEach(restaurants) { restaurant in
                
                  if viewModel.shouldShowItem(restaurant: restaurant) {
                    BasicImageRow(restaurant: restaurant)
                        .contextMenu {
                            
                            Button(action: {
                                // mark the selected restaurant as check-in
                                viewModel.toggleCheckIn(restaurant: restaurant)
                            }) {
                                HStack {
                                    Text("Check-in")
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                            
                            Button(action: {
                                // delete the selected restaurant
                                viewModel.delete(restaurant: restaurant)
                            }) {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                                             
                            Button(action: {
                                // mark the selected restaurant as favorite
                                viewModel.toggleFavorite(restaurant: restaurant)
                                
                            }) {
                                HStack {
                                    Text("Favorite")
                                    Image(systemName: "star")
                                }
                            }
                        }
                        .onTapGesture {
                            viewModel.selectedRestaurant = restaurant
                        }
                  }
                }
                .onDelete { (indexSet) in
                    viewModel.restaurants.remove(atOffsets: indexSet)
                }
            }
            
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing:

                Button(action: {
                    viewModel.showSettings = true
                }, label: {
                    Image(systemName: "gear").font(.title)
                        .foregroundColor(.black)
                })
            )
            .sheet(isPresented: $viewModel.showSettings) {
                SettingView().environmentObject(viewModel.almacen)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SettingStore())
    }
}*/
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Crear una instancia de RestaurantViewModel y pasar el SettingStore
        //let viewModel = RestaurantViewModel(almacen: viewModel.)
        
        // Configurar la vista de previsualización con el viewModel y el store
        return ContentView(viewModel: RestaurantViewModel())
            .environmentObject(self.viewModel.almacen) // Pasar SettingStore como EnvironmentObject
    }
}*/


