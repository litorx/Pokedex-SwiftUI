//
//  PokemonType.swift
//
//  Created by Vitor on 20/08/25.
//

import SwiftUI
import Foundation

enum PokemonType: String, Identifiable, CaseIterable, Codable {
    case normal, fire, water, grass, electric
    case ice, fighting, poison, ground, flying
    case psychic, bug, rock, ghost, dragon, dark, steel, fairy

    var id: String { rawValue }
}

extension PokemonType {
    var color: Color {
        switch self {
        case .normal:   return Color(red: 0.659, green: 0.655, blue: 0.478)
        case .fire:     return Color(red: 0.737, green: 0.290, blue: 0.047)
        case .water:    return Color(red: 0.227, green: 0.400, blue: 0.839)
        case .grass:    return Color(red: 0.180, green: 0.486, blue: 0.118)
        case .electric: return Color(red: 0.70,  green: 0.55,  blue: 0.05)
        case .ice:      return Color(red: 0.35,  green: 0.65,  blue: 0.65)
        case .fighting: return Color(red: 0.761, green: 0.180, blue: 0.157)
        case .poison:   return Color(red: 0.569, green: 0.212, blue: 0.561)
        case .ground:   return Color(red: 0.75,  green: 0.60,  blue: 0.25)
        case .flying:   return Color(red: 0.557, green: 0.475, blue: 0.910)
        case .psychic:  return Color(red: 0.753, green: 0.173, blue: 0.353)
        case .bug:      return Color(red: 0.408, green: 0.486, blue: 0.043)
        case .rock:     return Color(red: 0.498, green: 0.431, blue: 0.110)
        case .ghost:    return Color(red: 0.451, green: 0.341, blue: 0.592)
        case .dragon:   return Color(red: 0.435, green: 0.208, blue: 0.988)
        case .dark:     return Color(red: 0.439, green: 0.341, blue: 0.275)
        case .steel:    return Color(red: 0.55,  green: 0.55,  blue: 0.65)
        case .fairy:    return Color(red: 0.70,  green: 0.35,  blue: 0.55)
        }
    }
}

struct PokemonTypeSlot: Codable, Identifiable {
    let slot: Int
    let type: PokemonTypeInfo
    var id: Int { slot }
}

struct PokemonTypeInfo: Codable {
    let name: PokemonType
}

