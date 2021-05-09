//
//  Home.swift
//  UI-179
//
//  Created by にゃんにゃん丸 on 2021/05/09.
//

import SwiftUI

struct Home: View {
    @StateObject var model = DrawingViewModel()
    var body: some View {
        ZStack{
            NavigationView{
                
                VStack{
                    
                    if let _ = UIImage(data: model.imageData){
                        
                        
                        DrawingScreen()
                            .environmentObject(model)
                          
                            
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    
                                    
                                    Button(action: model.cancelImageEditing, label: {
                                        Image(systemName: "xmark")
                                            .font(.footnote)
                                            .foregroundColor(.accentColor)
                                    })
                                    
                                }
                            })
                        
                    }
                    
                    else{
                        
                        
                        Button(action: {
                            
                            withAnimation{
                                
                                model.showPicker.toggle()
                                
                                
                            }
                            
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: -5, y: -5)
                        })
                    }
                    
                    
                }
                .navigationTitle("Image Editor")
                
                
            }
            
            if model.addNewBox{
                
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                
                TextField("Enter", text: $model.textBoxes[model.currentIndex].text)
                    .font(.system(size: 35, weight: model.textBoxes[model.currentIndex].isBold ? .bold : .regular))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                HStack{
                    
                    
                    Button(action: {
                        
                        model.textBoxes[model.currentIndex].isAdded = true
                        
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        
                        withAnimation{
                            
                            
                            model.addNewBox = false
                        }
                        
                    }, label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: model.CanselTextView, label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                    
                    
                    
                }
                .overlay(
                
                    HStack(spacing:15){
                        
                        ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        
                        Button(action: {
                            
                            model.textBoxes[model.currentIndex].isBold.toggle()
                            
                        }, label: {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Bold":"Normal")
                        })
                        
                    }
                   
                )
                .frame(maxHeight: .infinity, alignment: .top)
                
                
                
                
            }
        }
        .sheet(isPresented: $model.showPicker, content: {
            ImagePicker(showPicer: $model.showPicker, imageData: $model.imageData)
        })
        .alert(isPresented: $model.showAlert, content: {
            Alert(title: Text("Message"), message: Text(model.message), dismissButton: .destructive(Text("OK")))
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
