//
//  TransactionsRepository.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation


protocol TransactionsRepository{
    func add(_ : Transaction,
             completion: @escaping (Result<Transaction,Error>) -> Void)
    func fetchAll(completion: @escaping (Result<[Transaction], Error>) -> Void)
}
