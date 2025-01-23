//
//  URLManager.swift
//  EventsReminder
//
//  Created by KaayZenn on 27/05/2024.
//

import Foundation
import UIKit

class URLManager {
    
    static func openURL(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
