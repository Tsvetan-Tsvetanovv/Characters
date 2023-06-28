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
                ForEach(viewModel.characterItems) { item in
                    CharacterView(item: item)
                        .padding(.vertical)
                        .onTapGesture {
                            viewModel.selectCharacter(item)
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
