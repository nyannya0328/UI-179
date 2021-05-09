//
//  ImagePicker.swift
//  UI-179
//
//  Created by にゃんにゃん丸 on 2021/05/09.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    
    
    @Binding var showPicer : Bool
    @Binding var imageData : Data
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
   
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : ImagePicker
        init(parent : ImagePicker) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let imageData = (info[.originalImage] as? UIImage)?.pngData(){
                
                parent.imageData = imageData
                parent.showPicer.toggle()
                
            }
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.showPicer.toggle()
            
        }
        
    }
    

}

