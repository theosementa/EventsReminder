//
//  TagRepository.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import Foundation
import SwiftUI

@Observable
final class TagRepository {
    static let shared = TagRepository()
    let viewContext = CoreDataStack.shared.viewContext
    
    var tags: [TagEntity] = []
}

extension TagRepository {
    
    func fetchTags() {
        let request = TagEntity.fetchRequest()
        do {
            self.tags = []
            let tags = try viewContext.fetch(request)
            self.tags = tags
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func createTag(name: String, color: UIColor) {
        let newTag = TagEntity(context: viewContext)
        newTag.id = UUID()
        newTag.name = name
        newTag.color = color
        
        CoreDataStack.shared.saveContext()
        
        tags.append(newTag)
        self.tags = tags
            .sorted { $0.name < $1.name }
    }
    
}
