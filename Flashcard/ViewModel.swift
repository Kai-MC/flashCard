//
//  ViewModel.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//

import Combine
import SwiftUI

class FlashcardsViewModel: ObservableObject {
    @Published var flashcards: [Flashcard] = []

    func addFlashcard(front: String, back: String) {
        let newCard = Flashcard(front: front, back: back)
        flashcards.append(newCard)
    }

    func updateFlashcard(id: UUID, front: String, back: String) {
        if let index = flashcards.firstIndex(where: { $0.id == id }) {
            flashcards[index].front = front
            flashcards[index].back = back
        }
    }
    
    func deleteFlashcard(id: UUID) {
        flashcards.removeAll { $0.id == id }
    }
}

// Define the Flashcard model
struct Flashcard: Identifiable {
    var id = UUID()
    var front: String
    var back: String
}
