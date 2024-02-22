//
//  FlashcardCreationView.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//
import SwiftUI

struct FlashcardCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FlashcardsViewModel
    @State private var frontText: String
    @State private var backText: String
    var flashcard: Flashcard?

    init(viewModel: FlashcardsViewModel, flashcard: Flashcard? = nil) {
        self.viewModel = viewModel
        self.flashcard = flashcard
        _frontText = State(initialValue: flashcard?.front ?? "")
        _backText = State(initialValue: flashcard?.back ?? "")
    }

    var body: some View {
        VStack {
            VStack{
                Text("Front")
                    .font(.headline)
                    .padding(.top)
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .frame(height: UIScreen.main.bounds.height / 4)
                    
                    TextField("Front", text: $frontText)
                        .padding(.horizontal)
                }
            }
            
            
            VStack{
                Text("Back")
                    .font(.headline)
                    .padding(.top)
                ZStack {
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .frame(height: UIScreen.main.bounds.height / 4)
                    
                    TextField("Back", text: $backText)
                        .padding(.horizontal)
                }
            }
            
            Button("Save") {
                if let flashcard = flashcard {
                    // Edit existing flashcard
                    viewModel.updateFlashcard(id: flashcard.id, front: frontText, back: backText)
                } else {
                    // Create new flashcard
                    viewModel.addFlashcard(front: frontText, back: backText)
                }
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            
            if flashcard != nil {
                Button("Delete") {
                    if let flashcard = flashcard {
                        viewModel.deleteFlashcard(id: flashcard.id)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding()
        .navigationBarTitle(flashcard != nil ? "Edit Flashcard" : "New Flashcard", displayMode: .inline)
    }
}
