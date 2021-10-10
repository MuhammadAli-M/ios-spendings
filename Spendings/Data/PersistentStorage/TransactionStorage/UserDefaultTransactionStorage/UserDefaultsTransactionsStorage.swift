//
//  UserDefaultsTransactionsStorage.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation

final class UserDefaultsTransactionsStorage{
    
    private let key = "UserDefaultsTransactionsStorage"
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard){
        self.userDefaults = userDefaults
    }
    
    private func fetchTransactions() -> [Transaction]{
        if let transactionsData = userDefaults.object(forKey: key) as? Data {
            do{
                let transactions = try JSONDecoder().decode([TransactionUDS].self, from: transactionsData)
                return transactions.map{ $0.toDomain()}
            }catch{
                debugLog("can't decode saved transactions: \(transactionsData),\nerror: \(error.localizedDescription)")
            }
        }else{
            debugLog("can't retrieve saved transactions with key: \(key)")
        }
        return []
    }

    private func persist(transactions: [Transaction]){
        let transactionsUSD = transactions.map{ TransactionUDS($0)}
        do{
            let transactionsUSDEncoded = try JSONEncoder().encode(transactionsUSD)
            userDefaults.set(transactionsUSDEncoded, forKey: key)
        }catch{
            debugLog("can't save transactions, transactions: \(transactions),\nerror: \(error.localizedDescription)")
        }
    }
    
    #if DEBUG
    func clearAll(){
        self.persist(transactions: [])
    }
    #endif
}

extension UserDefaultsTransactionsStorage: TransactionsStorage{
    func add(_ transaction: Transaction, completion: @escaping (Result<Transaction, Error>) -> Void) {
        var savedTransactions = fetchTransactions()
        savedTransactions.append(transaction)
        persist(transactions: savedTransactions)
        completion(.success(transaction)) // TODO: Handle the caching error later
    }

    func fetchAll(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let savedTransactions = fetchTransactions()
        completion(.success(savedTransactions)) // TODO: Handle the caching error later
    }
}
