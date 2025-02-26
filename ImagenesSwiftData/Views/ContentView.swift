//
//  ContentView.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    //Paso 1.3,ponemos el contexto
    @Environment(\.modelContext) private var context
    //Hacemos la query
    @Query private var images: [PhotoModel]
    @State private var show = false
    
    var body: some View {
        NavigationStack{
            VStack{
                //Paso 1.5, mostar la vista vacía
                if images.isEmpty{
                    ContentUnavailableView("Sin Imagenes", systemImage: "photo")
                }else{
                    //Paso 1.9
                    List{
                        ForEach(images){ item in
                                CardPhoto(item: item)
                                 //Eliminar
                                .swipeActions{
                                    Button(role: .destructive) {
                                        withAnimation{
                                            context.delete(item)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                            //Paso 1.10,Para que no nos ponga una linea por cada foto.
                        }.listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    //Paso 1.11
                    .shadow(color: Color.black, radius: 4, x: 3, y:2)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }
            }.padding(.all)
                //paso 1.4
                .navigationTitle("Images Data")
                .toolbar{
                    ToolbarItem{
                        Button {
                            show.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                    //Paso 1.8
                }.sheet(isPresented: $show) {
                    NavigationStack{
                        //Mandamos a llamar a nuestra vista
                        AddImageView()
                    }
                }
        }
    }
}

//V-448,Paso 1.8 card para nuestra foto
struct CardPhoto: View {
    var item: PhotoModel
    var body: some View {
        if let photoData = item.image, let uiImage = UIImage(data: photoData){
            VStack{
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(item.name)
                    .font(.title)
                    .bold()
            }.padding(.all)
                //Color por defecto del sistema, es un gris bajo
                .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}


#Preview {
    ContentView()
    //V-447,paso 1.2
        .modelContainer(for: PhotoModel.self, inMemory: true)
}
