//
//  SwiftUIView.swift
//  
//
//  Created by Magnus Jensen on 09/09/2021.
//

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon
    var body: some View {
        SpecificationsView(pokemon: pokemon)
        WeaknessView(pokemon: pokemon)
        StrengthView(pokemon: pokemon)
    }
}

struct SpecificationsView: View {
    let pokemon: Pokemon
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(pokemon.name)
                    .font(.title)
                Text(pokemon.number)
                    .foregroundColor(.gray)
            }
            GroupBox(label: Text("Specifications")) {
                Text("Height: \(pokemon.height)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Weight: \(pokemon.weight)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}

struct WeaknessView: View {
    let pokemon: Pokemon
    var body: some View {
        VStack {
            Text("Weakness")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TypesView(types: pokemon.weaknesses)
        }
    }
}

struct StrengthView: View {
    let pokemon: Pokemon
    var body: some View {
        VStack {
            Text("Strength")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TypesView(types: pokemon.type)
        }
    }
}

struct TypesView: View {
    let types: [PokemonType]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(types, id: \.self) { weakness in
                    Text(weakness.rawValue).bold()
                        .padding(4)
                        .padding(.horizontal, 4)
                        .background(background(for: weakness).opacity(0.3))
                        .foregroundColor(background(for: weakness))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func background(for type: PokemonType) -> Color {
        switch type {
        case .bug: return .init(.brown)
        case .fire: return .orange
        case .ice: return .blue
        case .flying: return .gray
        case .psychic: return .purple
        case .grass: return .green
        case .poison: return .green
        case .water: return .blue
        case .normal: return .gray.opacity(0.25)
        case .electric: return .yellow
        case .ground: return .init(.brown)
        case .fighting: return .init(.brown)
        case .rock: return .gray
        case .ghost: return .gray.opacity(0.25)
        case .dragon: return .purple
        case .fairy: return .init(.cyan)
        case .dark: return .init(.darkGray)
        case .steel: return .gray
        }
    }
}
