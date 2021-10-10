//
//  AddTransactionUseCase.swift
//  Spendings
//
//  Created by Muhammad Adam on 09/10/2021.
//

import Foundation

protocol AddTransactionUseCase {
    func execute(request: AddTransactionUseCaseRequestValue,
                 completion: @escaping (Result<Transaction,Error>) -> Void)
}

struct AddTransactionUseCaseRequestValue{
    let transaction: Transaction
}

final class DefaultAddTransactionUseCase: AddTransactionUseCase{
    private let transactionsRepo: TransactionsRepository
    
    init(transactionsRepo: TransactionsRepository){
        self.transactionsRepo = transactionsRepo
    }
    
    func execute(request: AddTransactionUseCaseRequestValue, completion: @escaping (Result<Transaction, Error>) -> Void)  {
        
        return transactionsRepo.add(request.transaction) { result in
            return completion(result)
        }
    }
}


protocol TransactionsRepository{
    func add(_ : Transaction,
             completion: @escaping (Result<Transaction,Error>) -> Void)
}

final class DefaultTransactionsRepository: TransactionsRepository{
    private let cache: TransactionsStorage
    
    init(cache: TransactionsStorage){
        self.cache = cache
    }
    
    func add(_ transaction: Transaction, completion: @escaping (Result<Transaction, Error>) -> Void) {
        
        cache.add(transaction) { result in
            completion(result)
        }
    }
}
// new class
protocol TransactionsStorage{
    func add(_ : Transaction,
             completion: @escaping (Result<Transaction,Error>) -> Void)
    func getAll(completion: @escaping (Result<[Transaction],Error>) -> Void)
}

// new class
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

    func getAll(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let savedTransactions = fetchTransactions()
        completion(.success(savedTransactions)) // TODO: Handle the caching error later
    }
}



struct TransactionUDS{
    let amount: Float
    let note: String
    let dateTimeInterval: String
    let categoryName: String
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    init(_ transaction: Transaction){
        self.amount = transaction.amount
        self.note = transaction.note
        self.dateTimeInterval = String(transaction.date.timeIntervalSince1970)
        self.categoryName = transaction.category.name
    }
    
    func toDomain() -> Transaction{
        let transactionDate = Date(timeIntervalSince1970:  TimeInterval(self.dateTimeInterval) ?? 0 )
        
        let transaction = Transaction(amount: self.amount,
                                      note: self.note,
                                      date: transactionDate,
                                      category: .init(name: self.categoryName))
        return transaction
    }
    
}

extension TransactionUDS: Codable{
    enum CodingKeys: CodingKey{
        case amount
        case note
        case dateTimeInterval
        case categoryName

    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.amount = try values.decode(Float.self, forKey: .amount)
//        self.note = try values.decode(String.self, forKey: .note)
//        self.date = try values.decode(String.self, forKey: .date)
//        self.categoryName = try values.decode(String.self, forKey: .categoryName)
//    }
//
//    func encode(to encoder: Encoder) throws {
//
//    }
}
