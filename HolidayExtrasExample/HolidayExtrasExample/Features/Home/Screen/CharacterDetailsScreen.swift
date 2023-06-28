//
//  CharacterDetailsScreen.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct CharacterDetailsScreen: View {

    private let character: Character

    init(character: Character) {
        self.character = character
    }

    var body: some View {
        VStack {
            AvatarView(url: URL(string: character.image), width: 200, height: 200)

            VStack(spacing: 5) {
                HStack(spacing: 5) {
                    Text("Name:")
                    Text(character.name)
                        .bold()
                }

                HStack(spacing: 5) {
                    Text("Species:")
                    Text(character.species)
                        .bold()
                }

                HStack(spacing: 5) {
                    Text("Gender:")
                    Text(character.gender)
                        .bold()
                }

                HStack(spacing: 5) {
                    Text("Status:")
                    Text(character.status)
                        .bold()
                }
            }
            .font(.title2)
        }
    }
}
