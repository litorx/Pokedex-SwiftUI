//
//  TextBorder.swift
//  Aula1
//
//  Created by Vitor on 27/08/25.
//

import SwiftUI

struct TextBorder: ViewModifier {
    var color: Color
    var lineWidth: Double
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Double) -> AnyView{
        if (lineWidth == 0){
            return content
        } else{
            return applyShadow(content: AnyView(content.shadow(color:color, radius: 0.12)), lineWidth: lineWidth - 1)
        }
    }
    
}

extension View {
    func textBorder(color: Color, linewidth: Double) -> some View {
        self.modifier(TextBorder(color: color, lineWidth: linewidth))
    }
}
