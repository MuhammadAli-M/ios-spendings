//
//  FetchAllTransactionsUseCaseTests.swift
//  SpendingsTests
//
//  Created by Muhammad Adam on 10/10/2021.
//

import XCTest
@testable import Spendings

class FetchAllTransactionsUseCaseTests: XCTestCase {

    lazy var repo = TransactionsRepositoryMock()
    lazy var sut = DefaultFetchAllTransactionsUseCase(transactionsRepo: repo)

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testAddOneTransactionSuccessfully() throws {
        let transaction = Transaction.stub(amount: 50, note: "Rice", category: .init(name: "Food"))
        
        // Add to the repo directly
        repo.add(transaction) { _ in }

        sut.execute{ result in
            switch result{
            case .success(let expectedTransaction):
                XCTAssertEqual(expectedTransaction, [transaction])
            case .failure(let error):
                XCTFail("Failure occured, error: \(error.localizedDescription)")
            }
        }
    }
    
    func testAddTwoTransactionsSuccessfully() throws {
        let trans1 = Transaction.stub(amount: 50, note: "Rice", category: .init(name: "Food"))
        let trans2 = Transaction.stub(amount: 100, note: "Cleaner", category: .init(name: "Home"))
        
        // Add to the repo directly
        repo.add(trans1) { _ in }
        repo.add(trans2) { _ in }
        
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

