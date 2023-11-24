//
//  BuildingView.swift
//  prototipo_projeto
//
//  Created by Student19_02 on 01/11/23.
//

import SwiftUI
import MapKit

struct BuildingView: View {
    @State var university: University
    @State var building: Building

    var body: some View {
        GeometryReader {
            geometry in
            let WIDTH = geometry.size.width
            let HEIGHT = geometry.size.height
            
            VStack {
                VStack {
                    Text(building.name!)
                        .font(.title)
                        .foregroundColor(Color("topics"))
                        .multilineTextAlignment(.center)
                    
                    Text(building.campus!)
                        .font(.caption)
                        .foregroundColor(Color(.gray))
                }
                
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: (building.image != nil && building.image != "") ? building.image! : "https://media.istockphoto.com/id/1091725686/vector/school-building-vector-modern-city-university-fasade-exterior-brick-isolated-flat-cartoon.jpg?s=170667a&w=0&k=20&c=9C5tVrHCvuep1OP8KRRVquggoJcaRYvhuq2v5_mc8QU=")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .cornerRadius(10)
                                .frame(minWidth: 0, maxWidth: WIDTH * 0.9)
                        } placeholder: {
                            ProgressView()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 0, maxWidth: WIDTH * 0.4)
                                .tint(Color("dark-green"))
                        }
                        
                        NavigationLink(destination: HomeView(university: university, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: building.latitude!, longitude: building.longitude!), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))) {
                            Text("Ver no mapa")
                                .foregroundColor(Color("boxes"))
                                .underline()
                        }
                    }
                    
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading) {
                            Text("Descrição")
                                .font(.title2)
                                .foregroundColor(Color("boxes"))
                                .padding(.bottom, 2)
                            
                            Text(building.description!)
                                .foregroundColor(.gray)
                        }
                        .frame(width: WIDTH * 0.9)
                        .padding(.top, 10)

                        VStack (alignment: .leading) {
                            Text("Salas")
                                .foregroundColor(Color("boxes"))
                                .font(.title2)
                            
                            ForEach(building.rooms!, id: \.self) { room in
                                VStack(alignment: .leading) {
                                    Text(room.name!)
                                    Text(room.location!)
                                }
                                .padding()
                                .frame(width: WIDTH * 0.9, height: HEIGHT * 0.10, alignment: .leading)
                                .background(Color("boxes"))
                                .foregroundColor(Color("boxes-text"))
                                .cornerRadius(20)
                            }
                        }.padding()
                    }.frame(width: WIDTH * 0.9)
                }
            }
            .frame(width: WIDTH, height: HEIGHT)
            .background(Color("background"))
        }
    }
}

struct BuildingView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingView(university: University(name: "Universidade de Mossoró", city: "Mossoró", buildings: [Building(name: "Edifício de Ciência", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")]), Building(name: "Edifício de Artes", latitude: -5.1832, longitude: -37.3441, description: "Este edifício abriga todos os cursos de artes.", courses: ["Arte", "Música", "Teatro"], rooms: [Room(name: "Estúdio de Arte", location: "Primeiro andar"), Room(name: "Sala de Música", location: "Segundo andar")])]), building: Building(name: "Edifício de Ciência", campus: "Campus Leste", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")], image: ""))
    }
}
