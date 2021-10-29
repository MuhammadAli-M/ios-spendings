//
//  CategoriesRepository.swift
//  Spendings
//
//  Created by Muhammad Adam on 27/10/2021.
//

import Foundation

protocol CategoriesRepository{
    func add(_ : Transaction.Category,
             completion: @escaping (Result<Transaction.Category,Error>) -> Void)
    func fetchAll(completion: @escaping (Result<[Transaction.Category], Error>) -> Void)
}
