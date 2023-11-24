//
//  BuildingsView.swift
//  prototipo_projeto
//
//  Created by Student19_02 on 01/11/23.
//

import SwiftUI

struct BuildingsView: View {
    @State var university: University
    @State var buildings: [Building]
    
    var body: some View {
        GeometryReader {
            geometry in
            
            let WIDTH = geometry.size.width
            let HEIGHT = geometry.size.height
            
            VStack {
                Text("EDIFICAÇÕES")
                    .foregroundColor(Color("topics"))
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                ScrollView {
                    ForEach(buildings, id: \.self) { building in
                        NavigationLink (destination: BuildingView(university: university, building: building)) {
                            HStack {
                                AsyncImage(url: URL(string: (building.image != nil && building.image != "") ? building.image! : "https://media.istockphoto.com/id/1091725686/vector/school-building-vector-modern-city-university-fasade-exterior-brick-isolated-flat-cartoon.jpg?s=170667a&w=0&k=20&c=9C5tVrHCvuep1OP8KRRVquggoJcaRYvhuq2v5_mc8QU=")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(minWidth: 0, maxWidth: WIDTH * 0.4)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(minWidth: 0, maxWidth: WIDTH * 0.4)
                                        .tint(.white)
                                }.padding(10)
                                
                                Spacer()
                                
                                Text(building.name!)
                                    .foregroundColor(Color("boxes-text"))
                                    
                                Spacer()
                            }.frame(width: WIDTH * 0.95)
                            .background(Color("boxes"))
                            .cornerRadius(10)
                        }
                    }
                }
            }.frame(width: WIDTH * 1, height: HEIGHT * 1)
                .background(Color("background"))
        }
    }
}

struct BuildingsView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingsView(university: University(name: "Universidade de Mossoró", city: "Mossoró", buildings: [Building(name: "Edifício de Ciência", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")]), Building(name: "Edifício de Artes", latitude: -5.1832, longitude: -37.3441, description: "Este edifício abriga todos os cursos de artes.", courses: ["Arte", "Música", "Teatro"], rooms: [Room(name: "Estúdio de Arte", location: "Primeiro andar"), Room(name: "Sala de Música", location: "Segundo andar")])]), buildings: [Building(name: "Edifício de Ciência", latitude: -5.1846, longitude: -37.3474, description: "Este é o edifício principal para os cursos de ciências.", courses: ["Física", "Química", "Biologia"], rooms: [Room(name: "Laboratório de Física", location: "Primeiro andar"), Room(name: "Laboratório de Química", location: "Segundo andar")], image: ""), Building(name: "Edifício de Artes", latitude: -5.1832, longitude: -37.3441, description: "Este edifício abriga todos os cursos de artes.", courses: ["Arte", "Música", "Teatro"], rooms: [Room(name: "Estúdio de Arte", location: "Primeiro andar"), Room(name: "Sala de Música", location: "Segundo andar")], image: "")])
    }
}
