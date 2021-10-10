//
//  TransactionsStorage.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation

protocol TransactionsStorage{
    func add(_ : Transaction,
             completion: @escaping (Result<Transaction,Error>) -> Void)
    func getAll(completion: @escaping (Result<[Transaction],Error>) -> Void)
}
