//
//  DrawingViewModel.swift
//  UI-179
//
//  Created by にゃんにゃん丸 on 2021/05/09.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject {
    
    @Published var showPicker = false
    @Published var imageData : Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    
    @Published var toolPicker = PKToolPicker()
    
    @Published var textBoxes : [TextBox] = []
    @Published var addNewBox = false
    
    @Published var currentIndex : Int = 0
    
    @Published var rect : CGRect = .zero
    
    @Published var showAlert = false
    @Published var message = ""
    
    
    
    
    func cancelImageEditing(){
        
        
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    
    func CanselTextView(){
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        withAnimation{
            
            addNewBox = false
            
            
        }
        
        if !textBoxes[currentIndex].isAdded{
        textBoxes.removeLast()
        }
        
        
    }
    
    func SaveImage(){
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        let swiftUIView = ZStack{
            
            ForEach(textBoxes){ [self]box in
                
                Text(textBoxes[currentIndex].id == box.id && addNewBox ? "" : box.text)
                    .font(.system(size: box.size))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
            }
            
            
            
        }
        
        
        let controller = UIHostingController(rootView: swiftUIView).view!
        controller.frame = rect
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
            
        
        
        let genelatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if let image = genelatedImage?.pngData(){
            
            UIImageWriteToSavedPhotosAlbum(UIImage(data:image)!, nil, nil, nil)
            
            print("Success")
            self.message = "OK"
            showAlert.toggle()
            
        }
        
        
    }
  
}


