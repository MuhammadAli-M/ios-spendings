//
//  TransactionUDS.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation

struct TransactionUDS{
    let amount: Float
    let note: String
    let dateTimeInterval: TimeInterval
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
        self.dateTimeInterval = transaction.date.timeIntervalSince1970
        self.categoryName = transaction.category.name
    }
    
    func toDomain() -> Transaction{
        let transactionDate = Date(timeIntervalSince1970:  self.dateTimeInterval)
        
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
