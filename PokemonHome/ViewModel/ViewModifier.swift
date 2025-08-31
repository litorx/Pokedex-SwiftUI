//
//  ViewModifier.swift
//
//  Created by Vitor on 27/08/25.
//

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

