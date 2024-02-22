//
//  FlashcardView.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//

import SwiftUI

struct FlashcardView: View {
    var flashcard: Flashcard
    var isFlipped: Bool

    var body: some View {
        VStack {
            Group {
                if isFlipped {
                    Text(flashcard.back)
                } else {
                    Text(flashcard.front)
                }
            }
            .rotation3DEffect(.degrees(isFlipped ? -180 : 0), axis: (x: 0, y: 1, z: 0)) // Counter-rotation for the text
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // Rotation for the card
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isFlipped ? Color.gray : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
