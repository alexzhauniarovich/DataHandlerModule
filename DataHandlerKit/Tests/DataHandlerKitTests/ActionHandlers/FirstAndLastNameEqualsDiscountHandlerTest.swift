//
//  FirstAndLastNameEqualsDiscountHandlerTest.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import XCTest
@testable import DataHandlerKit

final class FirstAndLastNameEqualsDiscountHandlerTest: XCTest {
    
    private var discountServiceMock = DiscountServiceMock()
    
    private let defaultDataSet = [
        Person(firstName: "Jenifer", lastName: "Radriges", age: 44),
        Person(firstName: "Bob", lastName: "Rees", age: 20),
        Person(firstName: "John", lastName: "Smith", age: 35)
    ]
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsWithFirstNameAndLastNameThenCallService() throws {
        let testObject = generateTestObject()
        let testFirstName = "Robert"
        let testLastName = "Martin"
        
        let result = testObject.handlePersons(defaultDataSet, params: [testFirstName, testLastName])
        
        XCTAssertTrue(discountServiceMock.discountCalculationCalls > 0)
        XCTAssertEqual(result, .processed)
    }
    
    func testWhenCallHandlePersonsWithDifferentFirstNameAndLastNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: ["Sarah", "Konor"])
        
        XCTAssertEqual(discountServiceMock.discountCalculationCalls, 0)
        XCTAssertEqual(result, .skipped)
    }
    
    func testWhenCallHandlePersonsWithDifferentFirstNameOnlyThenDidNotCallService() throws {
        let testObject = generateTestObject()
        let testFirstName = "Robert"
        
        let result = testObject.handlePersons(defaultDataSet, params: [testFirstName])
        
        XCTAssertEqual(discountServiceMock.discountCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    func testWhenCallHandlePersonsWithoutFirstNameAndLastNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [])
        
        XCTAssertEqual(discountServiceMock.discountCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    func testWhenCallHandlePersonsWithWrongFirstNameAndLastNameTypeThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [123, 8983])
        
        XCTAssertEqual(discountServiceMock.discountCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> FirstAndLastNameEqualsDiscountHandler {
        discountServiceMock = DiscountServiceMock()
        return FirstAndLastNameEqualsDiscountHandler(discountService: discountServiceMock)
    }
}

fileprivate final class DiscountServiceMock: DiscountService {
    
    // MARK: - Public fields
    
    private(set) var discountCalculationCalls = 0
    
    override func discountCalculation() {
        discountCalculationCalls += 1
    }
}
