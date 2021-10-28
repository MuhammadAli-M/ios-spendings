//
//  UserDefaultCategoriesStorage.swift
//  Spendings
//
//  Created by Muhammad Adam on 28/10/2021.
//

import Foundation

typealias UserDefaultCategoriesStorage = UserDefaultsStorage<Transaction.Category, CategoryUDS>

extension UserDefaultCategoriesStorage: CategoriesStorage{}

extension Transaction.Category: CachedItem {}

struct CategoryUDS: CachedElementUDS{
    
    typealias itemType = Transaction.Category
    let name: String

    func toDomain() -> itemType {
        return Transaction.Category(name: name)
    }
    
    init(_ category: itemType) {
        self.name = category.name
    }
}
