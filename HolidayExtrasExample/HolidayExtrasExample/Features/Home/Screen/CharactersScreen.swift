//
//  CharactersScreen.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct CharactersScreen: View {

    @ObservedObject private var viewModel: CharactersViewModel

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.characters, id: \.id) { character in
                    CharacterView(item: character)
                        .padding(.vertical)
                        .onTapGesture {
                            viewModel.select(character)
                        }
                }
            }
        }
        .navigationTitle("Characters")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.getCharacters()
        }
    }
}
