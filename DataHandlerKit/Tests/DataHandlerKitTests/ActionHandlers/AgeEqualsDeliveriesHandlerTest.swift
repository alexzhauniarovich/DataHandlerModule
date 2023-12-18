//
//  AgeEqualsDeliveriesHandlerTest.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import XCTest
@testable import DataHandlerKit

final class AgeEqualsDeliveriesHandlerTest: XCTest {
    
    private var deliveriesService = DeliveriesServiceMock()
    
    private let defaultDataSet = [
        Person(firstName: "Jenifer", lastName: "Radriges", age: 44),
        Person(firstName: "Bob", lastName: "Rees", age: 20),
        Person(firstName: "John", lastName: "Smith", age: 35)
    ]
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsWithAgeThenCallService() throws {
        let testObject = generateTestObject()
        let testAge = 20
        var persons = [Person(firstName: "John", lastName: "Smith", age: testAge)]
        persons.append(contentsOf: defaultDataSet)
        
        let result = testObject.handlePersons(persons, params: [testAge])
        
        XCTAssertEqual(deliveriesService.deliveriesCalculationCalls, 1)
        XCTAssertEqual(result, .processed)
    }
    
    func testWhenCallHandlePersonsWithDifferentAgeThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [88])
        
        XCTAssertEqual(deliveriesService.deliveriesCalculationCalls, 0)
        XCTAssertEqual(result, .skipped)
    }
    
    func testWhenCallHandlePersonsWithoutAgeThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: [])
        
        XCTAssertEqual(deliveriesService.deliveriesCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    func testWhenCallHandlePersonsWithWrongAgeThenDidNotCallService() throws {
        let testObject = generateTestObject()
        
        let result = testObject.handlePersons(defaultDataSet, params: ["age"])
        
        XCTAssertEqual(deliveriesService.deliveriesCalculationCalls, 0)
        XCTAssertEqual(result, .failed)
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> AgeEqualsDeliveriesHandler {
        deliveriesService = DeliveriesServiceMock()
        return AgeEqualsDeliveriesHandler(deliveriesService: deliveriesService)
    }
}

fileprivate class DeliveriesServiceMock: DeliveriesService {
    
    // MARK: - Public fields
    
    var deliveriesCalculationCalls = 0
    
    override func deliveriesCalculation() {
        deliveriesCalculationCalls += 1
    }
}
