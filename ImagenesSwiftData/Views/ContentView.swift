//
//  ContentView.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Paso 1.3,ponemos el contexto
    @Environment(\.modelContext) private var context
    // Hacemos la query y traemos nuestro model
    @Query private var images: [PhotoModel]
    // Variable para abrir una vista
    @State private var show = false
    
    var body: some View {
        NavigationStack{
            VStack{
                //Paso 1.5, mostar la vista vacía.
                if images.isEmpty{
                    ContentUnavailableView("Sin Imagenes", systemImage: "photo")
                }else{
                    // Paso 2.1
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
                                }//Swipe
                        }
                        // Paso 2.2,Para que no nos ponga una línea por cada foto.
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }// List
                    // Paso 2.3
                    .shadow(color: Color.black, radius: 4, x: 3, y:2)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }//else
            }//:V-STACK
            .padding(.all)
            // Paso 1.4
            .navigationTitle("Images Data")
            .toolbar{
                ToolbarItem{
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Paso 3.3
            .sheet(isPresented: $show) {
                NavigationStack{
                    // Mandamos a llamar a nuestra vista
                    AddImageView()
                }
            }
        }// Navigation Stack
    }
}

//V-448,Paso 2.0 card para nuestra foto
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
                
            }//:V-STACK
            .padding(.all)
            //Color por defecto del sistema, es un gris bajo
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}


#Preview {
    ContentView()
    // Paso 1.2
        .modelContainer(for: PhotoModel.self, inMemory: true)
}
