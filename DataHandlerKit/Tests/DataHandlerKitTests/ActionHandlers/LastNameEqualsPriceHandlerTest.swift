//
//  LastNameEqualsPriceHandlerTest.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import XCTest
@testable import DataHandlerKit

final class LastNameEqualsPriceHandlerTest: XCTest {
    
    private var priceServiceMock = PriceServiceMock()
    
    private let defaultDataSet = [
        Person(firstName: "Jenifer", lastName: "Radrigues", age: 44),
        Person(firstName: "Bob", lastName: "Rees", age: 20),
        Person(firstName: "John", lastName: "Smith", age: 35)
    ]
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsWithLastThenCallService() throws {
        let testObject = generateTestObject()
        let testLastName = "Radrigues"
        var persons = [Person(firstName: "John", lastName: testLastName, age: 18)]
        persons.append(contentsOf: defaultDataSet)
        
        let result = testObject.handlePersons(persons, params: [testLastName])
        
        XCTAssertEqual(priceServiceMock.priceCalculationCalls, 1)
        XCTAssertEqual(result, .processed)
    }
    
    func testWhenCallHandlePersonsWithDifferentLastThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: ["Watson"])
        
        XCTAssertEqual(priceServiceMock.priceCalculationCalls, 0)
        XCTAssertEqual(result, .skipped)
    }
    
    func testWhenCallHandlePersonsWithoutLastNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [])
        
        XCTAssertEqual(priceServiceMock.priceCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    func testWhenCallHandlePersonsWithWrongLastNameThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [889])
        
        XCTAssertEqual(priceServiceMock.priceCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> LastNameEqualsPriceHandler {
        priceServiceMock = PriceServiceMock()
        return LastNameEqualsPriceHandler(priceService: priceServiceMock)
    }
}

fileprivate final class PriceServiceMock: PriceService {
    
    // MARK: - Public fields
    
    private(set) var priceCalculationCalls = 0
    
    override func priceCalculation() {
        priceCalculationCalls += 1
    }
}
