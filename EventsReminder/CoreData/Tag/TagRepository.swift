//
//  TagRepository.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import Foundation
import SwiftUI
import WidgetKit

final class TagRepository: ObservableObject {
    static let shared = TagRepository()
    let viewContext = CoreDataStack.shared.viewContext
    
    @Published var tags: [TagEntity] = []
}

extension TagRepository {
    
    func fetchTags() {
        let request = TagEntity.fetchRequest()
        do {
            self.tags = []
            let tags = try viewContext.fetch(request)
            self.tags = tags
                .sorted { $0.name < $1.name }
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
    
    func deleteTag(_ tag: TagEntity) {
        viewContext.delete(tag)
        fetchTags()
        CoreDataStack.shared.saveContext()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}
