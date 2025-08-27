//
//  AddImageView.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//  

import SwiftUI
import SwiftData
import PhotosUI

//V-449,Paso 3.0
struct AddImageView: View {
    
    @Environment(\.modelContext) private var context
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var photoData : Data?
    @State private var name = ""
    //Para regresar
    @Environment(\.dismiss) var dismiss
    
    var body: some View {

        VStack{
            // Paso 3.2
            if let photoData, let uiImage = UIImage(data: photoData){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            
            Divider()
            
            // Para abrir la galería
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared() ){
                Label("Seleccionar imágen", systemImage: "photo")
            }

            if photoData != nil {
                TextField("Nombre", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button {
                    withAnimation{
                        let newImage = PhotoModel(image: photoData ?? Data(), name: name)
                        context.insert(newImage)
                        // Para que nos cierre la ventana modal
                        dismiss()
                    }
                } label: {
                    Text("Guardar imágen")
                }
                
                Spacer()
                

                Button {
                    withAnimation{
                        selectedPhoto = nil
                        photoData = nil
                    }
                } label: {
                    Text("Eliminar imágen")
                }.tint(Color.red)

                Spacer()
                
            }
        }//:V-STACK
        // Paso 3.1
        .navigationTitle("Agregar imágen")
        .padding(.all)
        // Para trabajar con la imágen.
        .task(id: selectedPhoto) {
            // Aquí tomamos la imágen de la galería
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                // Aqui pasamos el dato de la imágen
                photoData = data
            }
        }
    }
}

#Preview{
    AddImageView()
}
