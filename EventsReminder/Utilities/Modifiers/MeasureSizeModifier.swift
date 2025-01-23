//
//  MeasureSizeModifier.swift
//  Essential
//
//  Created by Theo Sementa on 05/02/2024.
//

import SwiftUI

struct MeasureSizeModifier: ViewModifier {
    let callback: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            callback(proxy.size)
                        }
                }
            }
    }
}

extension View {
    func measureSize(_ callback: @escaping (CGSize) -> Void) -> some View {
        modifier(MeasureSizeModifier(callback: callback))
    }
}
