//
//  QuizView.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: FlashcardsViewModel
    @State private var currentIndex: Int = 0
    @State private var flippedStates: [UUID: Bool] = [:] // 1. Track flipped state for each card

    var body: some View {
        VStack {
            Text("Card \(currentIndex + 1) of \(viewModel.flashcards.count)")
                .padding()

            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(Array(viewModel.flashcards.enumerated()), id: \.element.id) { (index, card) in
                            // 2. Pass the isFlipped state to FlashcardView
                            FlashcardView(flashcard: card, isFlipped: flippedStates[card.id, default: false])
                                .frame(width: UIScreen.main.bounds.width)
                                .id(index) // Use index for ScrollViewReader
//                                // 3. Apply a 3D rotation effect based on the flipped state
//                                .rotation3DEffect(
//                                    .degrees(flippedStates[card.id, default: false] ? 180 : 0),
//                                    axis: (x: 0, y: 1, z: 0)
//                                )
                                // 4. Toggle the flipped state when tapped
                                .onTapGesture {
                                    withAnimation {
                                        flippedStates[card.id] = !(flippedStates[card.id] ?? false)
                                    }
                                }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 2)
                HStack {
                    Button(action: {
                        // Navigate to previous card
                        withAnimation {
                            currentIndex = max(currentIndex - 1, 0)
                            scrollViewProxy.scrollTo(currentIndex, anchor: .center)
                        }
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                    .disabled(currentIndex <= 0)

                    Button(action: {
                        // Navigate to next card
                        withAnimation {
                            currentIndex = min(currentIndex + 1, viewModel.flashcards.count - 1)
                            scrollViewProxy.scrollTo(currentIndex, anchor: .center)
                        }
                    }) {
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                    .disabled(currentIndex >= viewModel.flashcards.count - 1)
                }
            }
        }
    }
}
