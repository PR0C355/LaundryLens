//
//  ContentView.swift
//  LaundryLens
//
//  Created by Oluwatumininu Oguntola on 10/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var imagePickerIsPresenting: Bool = false
    @State var classifications: Dictionary<String, LaundryLabel> = [:]
    @State var resultsIsPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "photo")
                    .onTapGesture {
                        imagePickerIsPresenting = true
                        sourceType = .photoLibrary
                    }
                
                Image(systemName: "camera")
                    .onTapGesture {
                        imagePickerIsPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.title)
            .foregroundColor(.blue)
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )

            
            
            VStack{
                Button(action: {
                    if uiImage != nil {
                        classify()
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                }
                
            }
        }
        
        .sheet(isPresented: $imagePickerIsPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $imagePickerIsPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classify()
                    }
                }
            
        }
        .sheet(isPresented: $resultsIsPresenting){
            ClassifiedContentView(classConfidence: classifications)
        }
        .padding()
    }
    
    struct ClassifiedContentView: View {
        @Environment(\.dismiss) var dismiss
        var classConfidence: Dictionary<String, LaundryLabel>
        
        
        var body: some View {
            VStack {
                ForEach(classConfidence.keys.sorted(), id: \.self) { classLabel in
//                    Text("\(classLabel) (\(classConfidence[classLabel]!.confidence)): \(classConfidence[classLabel]!.meaning[0]) - \(classConfidence[classLabel]!.meaning[1])")
                    Text("\(classConfidence[classLabel]!.meaning[0]): \(classConfidence[classLabel]!.meaning[1])")
                        .padding()
//                        .background(color)
                }

                Button("Press to dismiss") {
                    dismiss()
                }
                .font(.title)
                .padding()
                .background(.black)
            }
        }
    }
    
    func classify() {
        let resultClassification = classifier.detect(uiImage: uiImage!)
        uiImage = resultClassification.boxedImage
        let classConfidences = resultClassification.classConfidences ?? [:]
        for classified in classConfidences.sorted(by: { $0.1 > $1.1 }) {
            classifications[classified.0] = LaundryLabel(label: classified.0, meaning: classifier.getEnglishforLabel(classLabel: classified.0), confidence: classified.1)
        }
        resultsIsPresenting = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(classifier: ImageClassifier())
    }
}


