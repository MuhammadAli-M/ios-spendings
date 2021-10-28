//
//  UserDefaultsStorageTests.swift
//  SpendingsTests
//
//  Created by Muhammad Adam on 27/10/2021.
//

import XCTest
@testable import Spendings

class UserDefaultsStorageTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ClearAllItems() throws {
        let sut = UserDefaultsStorage<Transaction.Category, CategoryUDS>()
        sut.clearAll()
        
        sut.fetchAll { result in
            
            switch result{
            case .success(let items):
                
                XCTAssertTrue(items.isEmpty)
                
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
    
    func test_AddOneItem() throws {
        let sut = UserDefaultsStorage<Transaction.Category, CategoryUDS>()
        sut.clearAll()
        
        let category = Transaction.Category(name: "Rice")
        
        sut.add(category) { _ in }
        
        sut.fetchAll { result in
            
            switch result{
            case .success(let items):
                
                XCTAssertEqual(category, items.first)
                XCTAssertEqual(1, items.count)
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
    
    
    func test_AddTwoItems() throws {
        let sut = UserDefaultsStorage<Transaction.Category, CategoryUDS>()
        sut.clearAll()
        
        let cat1 = Transaction.Category(name: "Rice")
        let cat2 = Transaction.Category(name: "Salt")
        
        sut.add(cat1) { _ in }
        sut.add(cat2) { _ in }
        
        sut.fetchAll { result in
            
            switch result{
            case .success(let items):
                
                XCTAssertEqual([cat1, cat2], items)
                XCTAssertEqual(2, items.count)
            case .failure(let error):
                XCTFail("error occured: \(error.localizedDescription)")
            }
        }
    }
}
