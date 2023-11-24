//
//  HomeView.swift
//  prototipo_projeto
//
//  Created by Student19_02 on 01/11/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State var university: University
    @State var region: MKCoordinateRegion
    
    var body: some View {
        TabView {
            MapView(university: university, region: region)
            .badge(0)
            .tabItem {
                Label("Mapa", systemImage: "map")
            }
            
            BuildingsView(university: university, buildings: university.buildings!)
                .badge(0)
                .tabItem {
                    Label("Edificações", systemImage: "building.2")
                }.background(.white)
        }.onAppear(){
            UITabBar.appearance().isTranslucent = true
            UITabBar.appearance().backgroundColor = UIColor(Color("tabview"))
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color("unselected"))
        }
        .accentColor(Color("selected"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(university: University(name: "Universidade de Mossoró", city: "Mossoró", buildings: [Building(name: "Edifício de Ciência", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")]), Building(name: "Edifício de Artes", latitude: -5.1832, longitude: -37.3441, description: "Este edifício abriga todos os cursos de artes.", courses: ["Arte", "Música", "Teatro"], rooms: [Room(name: "Estúdio de Arte", location: "Primeiro andar"), Room(name: "Sala de Música", location: "Segundo andar")])]), region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -20, longitude: 20), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
}
