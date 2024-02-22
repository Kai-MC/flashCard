//
//  MyCardsView.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//

import SwiftUI


struct MyCardsView: View {
    @ObservedObject var viewModel: FlashcardsViewModel
    @State private var showingCreationView = false
    @State private var editingFlashcard: Flashcard?

    var body: some View {
        NavigationView {
            VStack {
                Text("Total Cards: \(viewModel.flashcards.count)")
                    .font(.headline)
                    .padding()

                List {
                    ForEach(viewModel.flashcards) { flashcard in
                            Text(flashcard.front)
                        .frame(width: 300, height: 50) // Set the desired size here
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.vertical, 4)
                        .onTapGesture {
                            self.editingFlashcard = flashcard
                            showingCreationView = true
                        }
                    }
                }
            }
            .navigationBarTitle("My Cards", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                self.editingFlashcard = nil
                showingCreationView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingCreationView) {
                FlashcardCreationView(viewModel: viewModel, flashcard: self.editingFlashcard)
            }
        }
    }
}
