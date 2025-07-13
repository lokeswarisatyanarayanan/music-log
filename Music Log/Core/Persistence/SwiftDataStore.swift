//
//  SwiftDataStore.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import SwiftData

protocol SwiftDataStoreProtocol {
    func insert<Model: PersistentModel>(_ model: Model)
    
    func fetch<Model: PersistentModel>(
        of modelType: Model.Type,
        where predicate: Predicate<Model>?
    ) -> [Model]
    
    func fetch<Model: PersistentModel>(
        of modelType: Model.Type,
        where predicate: Predicate<Model>?,
        sort: [SortDescriptor<Model>]
    ) -> [Model]
    
    func delete<Model: PersistentModel>(_ model: Model)
    
    func deleteAll<Model: PersistentModel>(where predicate: Predicate<Model>?)
    
    func save()
}

final class SwiftDataStore: SwiftDataStoreProtocol {
    
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func insert<Model: PersistentModel>(_ model: Model) {
        context.insert(model)
    }

    func fetch<Model: PersistentModel>(
        of modelType: Model.Type,
        where predicate: Predicate<Model>? = nil,
        sort: [SortDescriptor<Model>] = []
    ) -> [Model] {
        let descriptor = FetchDescriptor<Model>(predicate: predicate, sortBy: sort)
        return (try? context.fetch(descriptor)) ?? []
    }

    func fetch<Model>(of modelType: Model.Type, where predicate: Predicate<Model>?) -> [Model] where Model : PersistentModel {
        let descriptor = FetchDescriptor<Model>(predicate: predicate, sortBy: [])
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func delete<Model: PersistentModel>(_ model: Model) {
        context.delete(model)
    }

    func deleteAll<Model: PersistentModel>(where predicate: Predicate<Model>? = nil) {
        let models = fetch(of: Model.self, where: predicate)
        for model in models {
            context.delete(model)
        }
    }

    func save() {
        do {
            try context.save()
        } catch {
            assertionFailure("⚠️ Save error: \(error.localizedDescription)")
        }
    }
}

