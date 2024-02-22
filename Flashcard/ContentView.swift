//
//  ContentView.swift
//  Flashcard
//
//  Created by Yukai Ma on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FlashcardsViewModel()

    var body: some View {
        TabView {
            MyCardsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("My Cards")
                }

            QuizView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                    Text("Quiz")
                }
        }
    }
}


#Preview {
    ContentView()
}
