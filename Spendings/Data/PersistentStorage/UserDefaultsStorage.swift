//
//  UserDefaultsStorage.swift
//  Spendings
//
//  Created by Muhammad Adam on 27/10/2021.
//

import Foundation
import UIKit

protocol CachedItem{}
protocol CachedElementUDS: Codable{
    associatedtype itemType
    func toDomain() -> itemType
    init?(_ : itemType)
}

final class UserDefaultsStorage<Element: CachedItem, ElementUDS: CachedElementUDS> where ElementUDS.itemType == Element{
    
    let key: String // TODO: update it
    private var userDefaults: UserDefaults
//    private var transactions: [Transaction]? = nil // TODO: Add it so as not to read from userdefaults each time
    
    init(key: String,userDefaults: UserDefaults = .standard){
        self.userDefaults = userDefaults
        self.key = key
    }
    
    private func fetchAllElements() -> [Element]{
        if let transactionsData = userDefaults.object(forKey: key) as? Data {
            do{
                let transactions = try JSONDecoder().decode([ElementUDS].self, from: transactionsData)
                return transactions.map{ $0.toDomain()}
            }catch{
                debugLog("can't decode saved items: \(transactionsData),\nerror: \(error.localizedDescription)")
            }
        }else{
            debugLog("can't retrieve saved items with key: \(key)")
        }
        return []
    }

    private func persist(transactions: [Element]){
        let transactionsUSD = transactions.map{ ElementUDS($0)}
        do{
            let transactionsUSDEncoded = try JSONEncoder().encode(transactionsUSD)
            userDefaults.set(transactionsUSDEncoded, forKey: key)
        }catch{
            debugLog("can't save item, items: \(transactions),\nerror: \(error.localizedDescription)")
        }
    }
    
    #if DEBUG
    func clearAll(){
        self.persist(transactions: [])
    }
    #endif
}


extension UserDefaultsStorage{
    func add(_ transaction: Element, completion: @escaping (Result<Element, Error>) -> Void) {
        var savedTransactions = fetchAllElements() // TODO: add guard from running on different threads
        savedTransactions.append(transaction)
        persist(transactions: savedTransactions)
        completion(.success(transaction)) // TODO: Handle the caching error later
    }

    func fetchAll(completion: @escaping (Result<[Element], Error>) -> Void) {
        let savedTransactions = fetchAllElements() // TODO: add guard from running on different threads
        completion(.success(savedTransactions)) // TODO: Handle the caching error later
    }
}

