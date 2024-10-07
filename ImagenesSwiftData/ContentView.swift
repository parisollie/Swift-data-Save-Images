//
//  ContentView.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    //Vid 447
    @Environment(\.modelContext) private var context
    @Query private var images: [PhotoModel]
    @State private var show = false
    
    var body: some View {
        NavigationStack{
            VStack{
                //Vid 447
                if images.isEmpty{
                    ContentUnavailableView("Sin Imagenes", systemImage: "photo")
                }else{
                    //Vid 448
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
                            //Vid 447,para que no nos ponga una linea por cada foto.
                        }.listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .shadow(color: Color.black, radius: 4, x: 3, y:2)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }
            }.padding(.all)
                .navigationTitle("Images Data")
                .toolbar{
                    ToolbarItem{
                        Button {
                            show.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }.sheet(isPresented: $show) {
                    NavigationStack{
                        AddImageView()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
    //Vid 447
        .modelContainer(for: PhotoModel.self, inMemory: true)
}

//Vid 448, card para nuestra foto
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
                .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}



