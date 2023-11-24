//
//  ContentView.swift
//  prototipo_projeto
//
//  Created by Student19_02 on 30/10/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var university: University? = nil
    @State var selecionado = "Selecione a Universidade"
    
    var body: some View {
        NavigationStack {
            GeometryReader{
                geometry in
                
                let HEIGHT = geometry.size.height
                let WIDTH = geometry.size.width
                
                VStack {
                    VStack {
                        Text("UNIVER MAP")
                            .font(.system(size: HEIGHT * 0.1, weight: .bold))
                            .foregroundColor(Color("light-green"))
                            .multilineTextAlignment(.center)
                            .padding(.top, HEIGHT * 0.05)
                            .onTapGesture {
                                viewModel.fetch()
                            }
                        
                        HStack {
                            Rectangle()
                                .frame(width: (WIDTH * 0.5), height: 2)
                            
                            Image(systemName: "globe")
                                .imageScale(.large)
                            
                            Rectangle()
                                .frame(width: (WIDTH * 0.5), height: 2)
                        }.foregroundColor(Color("home-detail"))
                    }.padding(.bottom, HEIGHT * 0.15)
                    
                    VStack{
                        HStack {
                            if viewModel.universities.isEmpty {
                                ProgressView("Carregando Universidades...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    .frame(width: WIDTH * 0.9, height: HEIGHT * 0.08)
                            } else {
                                Menu(selecionado) {
                                    ForEach(viewModel.universities) { uni in
                                        Button(uni.name!){
                                            university = uni
                                            selecionado =  uni.name!
                                        }
                                    }
                                }.accentColor(Color("white"))
                                    .padding()
                                    .frame(width: WIDTH * 0.9)
                                    .multilineTextAlignment(.center)
                                    .border(Color("light-green"), width: 1)
                                    .background(Color("light-green"))
                            }
                        }
                        .frame(width: WIDTH * 0.9, height: HEIGHT * 0.08)
                        .background(Color("white"))
                        .cornerRadius(10)
                        .padding(15)
                        
                        if(university != nil) {
                            NavigationLink (destination: HomeView(university: university!, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: university!.buildings![0].latitude!, longitude:  university!.buildings![0].longitude!), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))) {
                                    Text(Image(systemName: "magnifyingglass"))
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(Color("white"))
                                        .padding(.leading, 10)
                                }
                                .frame(width: WIDTH * 0.9, height: HEIGHT * 0.08)
                                .background(Color("dark-blue"))
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "c.circle")
                        Text("2023 UniverMap")
                    }.padding()
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(width: WIDTH,
                       height: HEIGHT)
                .background(Color("background"))
                .onAppear() {
                    viewModel.fetch()
                }
            }
        }
        .accentColor(Color("light-blue"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
