//
//  AppModel.swift
//  prototipo_projeto
//
//  Created by Student19_02 on 06/11/23.
//

import Foundation

struct University: Codable, Hashable{
    var name: String?
    var city: String?
    var buildings: [Building]?
}

extension University : Identifiable {
    public var id: String {
        "\(name!)-\(city!)"
    }
}

struct Room: Codable, Hashable{
    var name: String?
    var location: String?
}

struct Building: Codable, Hashable{
    var name: String?
    var campus: String?
    var latitude: Double?
    var longitude: Double?
    var description: String?
    var courses: [String]?
    var rooms: [Room]?
    var image: String?
}

extension Building: Identifiable {
    public var id: String {
        "\(String(describing: latitude))-\(String(describing: longitude))"
    }
}

class ViewModel: ObservableObject {
    @Published var universities: [University] = []
    
    func fetch() {
        guard let url = URL(string: "http://192.168.128.251:1880/getuniversities") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([University].self, from: data)
                
                DispatchQueue.main.async {
                    self?.universities = parsed
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}


//var faculdadeTeste = [
//    Faculdade(nome: "UFERSA",
//              predios: [
//                Predio(nome: "Central de Aulas III",
//                       latitude: -5.206628903449681,
//                       longitude: -37.32321098934607,
//                       cursos: [],
//                       salas: [
//                        Sala(nome: "Sala 01",
//                             localizacao: "Térreo"),
//                        Sala(nome: "Laboratório de Informática I",
//                             localizacao: "Térreo")
//                        ]
//                      ),
//                Predio(nome: "Central de Aulas VI",
//                       latitude: -5.206628903449681,
//                       longitude: -37.32321098934607,
//                       cursos: [],
//                       salas: [
//                        Sala(nome: "Sala 01",
//                             localizacao: "Térreo"),
//                        Sala(nome: "Laboratório de Informática I",
//                             localizacao: "Térreo")
//                        ]
//                      )
//                ]
//             )
//]



//[{"_id":"15ed4ffa5df47dded7250ebff9453393","_rev":"1-61ab19c15d7a6a6cf3eaa2ccedcc1f17","name":"Universidade de Mossoró","city":"Mossoró","buildings":[{"name":"Edifício de Ciências","latitude":-5.1846,"longitude":-37.3474,"description":"Este é o edifício principal para os cursos de ciências.","courses":["Física","Química","Biologia"],"rooms":[{"name":"Laboratório de Física","location":"Primeiro andar"},{"name":"Laboratório de Química","location":"Segundo andar"}]},{"name":"Edifício de Artes","latitude":-5.1832,"longitude":-37.3441,"description":"Este edifício abriga todos os cursos de artes.","courses":["Arte","Música","Teatro"],"rooms":[{"name":"Estúdio de Arte","location":"Primeiro andar"},{"name":"Sala de Música","location":"Segundo andar"}]}]},{"_id":"6415c9fdd7866a0910335264ce23c8dd","_rev":"1-c76ca6a763da59ac38efada8138c3353","nomeFaculdade":"UFERSA Legal","cidade":"Mossoró","predios":[{"id":"LCC","nome":"LCC","latitude":-5.206730377572517,"longitude":-37.32394302245662,"cursos":[{"nome":"ciência da computacao","area":"computacao"},{"nome":"CIT","area":"engenharia"}]},{"id":"centralIV","nome":"Central de Aulas VI","latitude":-5.206628903449681,"longitude":-37.32321098934607,"cursos":[{"nome":"Algebra Linear","area":"Matemática"},{"nome":"Filosofia da Ciencia e Met. Científica","area":"Filosofia"}]}]}]


//regionHome: MKCoordinateRegion(
//    center: CLLocationCoordinate2D(latitude: university!.buildings[0].latitude!, longitude: university!.buildings[0].longitude!),
//    span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)), buildingsHome: university!.buildings)
