//
//  BackgroundComponentViewModifier.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation
import SwiftUI

struct BackgroundComponentViewModifier: ViewModifier {
    
    var radius: CGFloat?
    var isInSheet: Bool?
    var isPaddingEnabled: Bool?
    
    var containerColor: Color?
    var strokeColor: Color?
    var strokeLineWidth: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .padding((isPaddingEnabled ?? true) ? 12 : 0)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: radius ?? 12, style: .continuous)
                        .fill(containerColor ?? ((isInSheet ?? false) ? Color.Apple.backgroundComponentSheet : Color.Apple.backgroundComponent))
                    
                    RoundedRectangle(cornerRadius: radius ?? 12, style: .continuous)
                        .stroke(lineWidth: strokeLineWidth ?? 2)
                        .fill(strokeColor ?? Color.Apple.componentInComponent)
                }
            }
    }
}

extension View {
    
    func backgroundComponent(
        radius: CGFloat? = nil,
        isInSheet: Bool? = nil,
        isPaddingEnabled: Bool? = nil,
        containerColor: Color? = nil,
        strokeColor: Color? = nil,
        strokeLineWidth: CGFloat? = nil
    ) -> some View {
        modifier(
            BackgroundComponentViewModifier(
                radius: radius,
                isInSheet: isInSheet,
                isPaddingEnabled: isPaddingEnabled,
                containerColor: containerColor,
                strokeColor: strokeColor,
                strokeLineWidth: strokeLineWidth
            )
        )
    }
    
}
