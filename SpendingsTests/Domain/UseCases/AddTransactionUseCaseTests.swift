//
//  AddTransactionUseCaseTests.swift
//  SpendingsTests
//
//  Created by Muhammad Adam on 09/10/2021.
//

import XCTest
@testable import Spendings

class AddTransactionUseCaseTests: XCTestCase {
    
    class TransactionsRepositoryMock: TransactionsRepository{
        var transactions: [Transaction] = []
        func add(_ transaction: Transaction, completion: @escaping (Result<Transaction, Error>) -> Void) {
            transactions.append(transaction)
            completion(.success(transaction))
        }
        
        func fetchAll(completion: @escaping (Result<[Transaction], Error>) -> Void) {
            completion(.success(transactions))
        }
        
    }
    
//    let storage = UserDefaultsTransactionsStorage()
    lazy var repo = TransactionsRepositoryMock()
    lazy var sut = DefaultAddTransactionUseCase(transactionsRepo: repo)
    
    override func setUpWithError() throws {    }
    override func tearDownWithError() throws {   }

    func testAddOneTransactionSuccessfully() throws {
        let transaction = Transaction.stub(amount: 50, note: "Rice", category: .init(name: "Food"))
        let request = AddTransactionUseCaseRequestValue(transaction: transaction)

        sut.execute(request: request) { result in
            switch result{
            case .success(let expectedTransaction):
                XCTAssertEqual(expectedTransaction, transaction)
            case .failure(let error):
                XCTFail("Failure occured, error: \(error.localizedDescription)")
            }
        }
    }
    
    func testAddTwoTransactionsSuccessfully() throws {
        let trans1 = Transaction.stub(amount: 50, note: "Rice", category: .init(name: "Food"))
        let trans2 = Transaction.stub(amount: 100, note: "Cleaner", category: .init(name: "Home"))
        
        sut.execute(request: AddTransactionUseCaseRequestValue(transaction: trans1)) { _ in }
        sut.execute(request: AddTransactionUseCaseRequestValue(transaction: trans2)) { _ in }
        
        repo.fetchAll(completion: { result in
            switch result{
            case .success(let expectedTransaction):
                XCTAssertEqual(expectedTransaction, [trans1, trans2])
            case .failure(let error):
                XCTFail("Failure occured, error: \(error.localizedDescription)")
            }
        })
    }

    
}

extension Transaction{
    static func stub(amount: Float =  25.0,
        note: String =  "Milk",
        date: Date =  Date(timeIntervalSince1970: 1633839399),
        category: Category =  .init(name: "Food")) -> Self{
        
        Transaction(amount: amount,
                    note: note,
                    date: date,
                    category: category)
    }
}
