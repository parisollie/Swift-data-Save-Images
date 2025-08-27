//
//  AddImageView.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//  

import SwiftUI
import SwiftData
import PhotosUI

//V-449,Paso 1.12
struct AddImageView: View {
    
    @Environment(\.modelContext) private var context
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var photoData : Data?
    @State private var name = ""
    //Para regresar
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //Paso 1.13
        VStack{
            //Paso 1.15
            if let photoData, let uiImage = UIImage(data: photoData){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            Divider()
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared() ){
                Label("Seleccionar imagen", systemImage: "photo")
            }
            //Paso 1.16
            if photoData != nil {
                TextField("Nombre", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button {
                    withAnimation{
                        let newImage = PhotoModel(image: photoData ?? Data(), name: name)
                        context.insert(newImage)
                        //Para que nos cierre la ventana modal
                        dismiss()
                    }
                } label: {
                    Text("Guardar Imagen")
                }
                Spacer()
                
                //Paso 1.17,Para eliminar la imagén.
                Button {
                    withAnimation{
                        selectedPhoto = nil
                        photoData = nil
                    }
                } label: {
                    Text("Eliminar imagen")
                }.tint(Color.red)

                Spacer()
                
                
            }
            
        }
        //Paso 1.14
        .navigationTitle("Agregar Imagen")
        .padding(.all)
        //Para trabajar con la imagen.
        .task(id: selectedPhoto) {
            //aqui tomamos la imagen de la galeria
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                photoData = data
            }
        }
    }
}

#Preview{
    AddImageView()
}
