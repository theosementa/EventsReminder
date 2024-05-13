//
//  UIScreen.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import Foundation
import UIKit

extension UIScreen {
    public var displayCornerRadius: CGFloat {
        guard let cornerRadius = self.value(forKey:"_displayCornerRadius") as? CGFloat else {
            return 0
        }
        return cornerRadius
    }
}
