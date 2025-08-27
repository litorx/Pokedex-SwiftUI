//
//  ViewModifier.swift
//  Aula1
//
//  Created by Vitor on 27/08/25.
//

// View+OutlinedText.swift
import SwiftUI

extension Text {
    func outlined(
        strokeColor: Color = .black,
        lineWidth: CGFloat = 2
    ) -> some View {
        self.overlay(
            self
                .strokeBorder(strokeColor, lineWidth: lineWidth)
        )
    }
}

