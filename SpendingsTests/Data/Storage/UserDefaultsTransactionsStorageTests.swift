//
//  UserDefaultsTransactionsStorageTests.swift
//  SpendingsTests
//
//  Created by Muhammad Adam on 09/10/2021.
//

import XCTest
@testable import Spendings

class UserDefaultsTransactionsStorageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ClearAllTransactions() throws {
        let sut = UserDefaultsTransactionsStorage()
        sut.clearAll()

        sut.fetchAll { result in
            
            switch result{
            case .success(let transactions):
                
                XCTAssertTrue(transactions.isEmpty)
                
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
    
    func test_AddOneTransaction() throws {
        let sut = UserDefaultsTransactionsStorage()
        sut.clearAll()
        
        let trans = Transaction(amount: 25.0,
                                note: "Milk",
                                date: Date(timeIntervalSince1970: 1633839399),
                                category: .init(name: "Food"))

        sut.add(trans) { _ in }
        sut.fetchAll { result in

            switch result{
            case .success(let transactions):
                
                XCTAssertEqual(trans, transactions.first)
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
    
    
    func test_AddTwoTransactions() throws {
        let sut = UserDefaultsTransactionsStorage()
        sut.clearAll()
        
        let trans1 = Transaction.stub(amount: 50, note: "Rice", category: .init(name: "Food"))
        let trans2 = Transaction.stub(amount: 100, note: "Cleaner", category: .init(name: "Home"))
        
        sut.add(trans1) { _ in }
        sut.add(trans2) { _ in }
        
        sut.fetchAll { result in

            switch result{
            case .success(let transactions):
                
                XCTAssertEqual([trans1,trans2], transactions)
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
}
