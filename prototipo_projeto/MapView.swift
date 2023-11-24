//
//  MapView.swift
//  prototipo_projeto
//
//  Created by Student04 on 30/10/23.
//

import SwiftUI
import MapKit

struct SuperTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct MapView: View {
    @State var university: University
    @State var region: MKCoordinateRegion
    @State private var building_name = ""
    @State private var showSuggestions = false
    @State private var building = ""
    @State var text: String = "TextField Text"
    
    var body: some View {
        GeometryReader {
            geometry in
            
            let HEIGHT = geometry.size.height
            let WIDTH = geometry.size.width
            
            ZStack {
                Map(coordinateRegion: $region, annotationItems: university.buildings!) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)) {
                        NavigationLink(destination: BuildingView(university: university, building: location)) {
                            VStack {
                                AsyncImage(url: URL(string: "https://icones.pro/wp-content/uploads/2021/02/icone-de-broche-de-localisation-verte.png")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                } placeholder: {
                                    Color.gray
                                }
                                
                                Text(location.name!)
                                    .font(.caption)
                                    .foregroundColor(Color("dark-green"))
                            }
                        }
                    }
                }
                
                VStack {
                    Text(university.name!.uppercased())
                        .padding(5)
                        .font(.system(size: HEIGHT * 0.04, weight: .bold))
                        .foregroundColor(Color("topics"))
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("background"))

                    HStack{
                        Text(Image(systemName: "magnifyingglass"))
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("white"))
                            .padding(.leading, 20)
                        
                        SuperTextField(placeholder: Text("Pesquise a edificação").foregroundColor(Color("white")), text: $building_name, editingChanged: { isEditing in
                            self.showSuggestions = true
                        }, commit: {
                            self.showSuggestions = false
                        })
                        .accentColor(Color("white"))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .foregroundColor(Color("white"))
                    }.padding(10)
                    .background(Color("light-green"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("light-green"), lineWidth: 6.5))
                    .cornerRadius(30)
                    .zIndex(99)
                    .frame(width: WIDTH * 0.9, height: HEIGHT * 0.1)

                    if showSuggestions && !building_name.isEmpty {
                        let filteredBuildings = university.buildings!.filter {
                            building in building.name?.lowercased().contains(building_name.lowercased()) ?? false
                        }
                        
                        if !filteredBuildings.isEmpty {
                            List(filteredBuildings, id: \.self) {building in
                                NavigationLink(building.name!, destination: BuildingView(university: university, building: building))
                            }.padding(.top, -40)
                            .scrollContentBackground(.hidden)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(university: University(name: "Universidade de Mossoró", city: "Mossoró", buildings: [Building(name: "Edifício de Ciência", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")]), Building(name: "Edifício de Artes", latitude: -5.1832, longitude: -37.3441, description: "Este edifício abriga todos os cursos de artes.", courses: ["Arte", "Música", "Teatro"], rooms: [Room(name: "Estúdio de Arte", location: "Primeiro andar"), Room(name: "Sala de Música", location: "Segundo andar")])]),
            region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -5.206730377572517, longitude: -37.32394302245662),span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
}
