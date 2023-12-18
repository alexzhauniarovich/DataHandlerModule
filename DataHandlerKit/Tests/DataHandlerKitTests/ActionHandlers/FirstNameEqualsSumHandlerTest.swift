//
//  AgeEqualsDeliveriesHandlerTest.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import XCTest
@testable import DataHandlerKit

final class FirstNameEqualsSumHandlerTest: XCTest {
    
    private var sumService = SumServiceMock()
    
    private let defaultDataSet = [
        Person(firstName: "Jenifer", lastName: "Radriges", age: 44),
        Person(firstName: "Bob", lastName: "Rees", age: 20),
        Person(firstName: "John", lastName: "Smith", age: 35)
    ]
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsWithFirstNameThenCallService() throws {
        let testObject = generateTestObject()
        let testName = "John"
        
        let result = testObject.handlePersons(defaultDataSet, params: [testName])
        
        XCTAssertTrue(sumService.sumCalculationCalls > 0)
        XCTAssertEqual(result, .processed)
    }
    
    func testWhenCallHandlePersonsWithDifferentFirstNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: ["Sarah"])
        
        XCTAssertEqual(sumService.sumCalculationCalls, 0)
        XCTAssertEqual(result, .skipped)
    }
    
    func testWhenCallHandlePersonsWithoutFirstNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [])
        
        XCTAssertEqual(sumService.sumCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    func testWhenCallHandlePersonsWithWrongFirstNameTypeThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [123])
        
        XCTAssertEqual(sumService.sumCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> FirstNameEqualsSumHandler {
        sumService = SumServiceMock()
        return FirstNameEqualsSumHandler(sumService: sumService)
    }
}

fileprivate final class SumServiceMock: SumService {
    
    // MARK: - Public fields
    
    private(set) var sumCalculationCalls = 0
    
    override func sumCalculation() {
        sumCalculationCalls += 1
    }
}
