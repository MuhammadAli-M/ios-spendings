//
//  DefaultCategoryRepository.swift
//  Spendings
//
//  Created by Muhammad Adam on 27/10/2021.
//

import Foundation

final class DefaultCategoryRepository: CategoriesRepository{
    
    typealias Cache = CategoriesStorage
    
    private let cache: Cache
    
    init(cache: Cache){
        self.cache = cache
    }
    
    func add(_ category: Transaction.Category, completion: @escaping (Result<Transaction.Category, Error>) -> Void) {
        
        cache.add(category) { result in
            completion(result)
        }
    }
    
    func fetchAll(completion: @escaping (Result<[Transaction.Category], Error>) -> Void){
        cache.fetchAll(completion: { result in
            completion(result)
        })
    }
}

