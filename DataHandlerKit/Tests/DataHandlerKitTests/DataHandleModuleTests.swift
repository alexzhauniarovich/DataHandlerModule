//
//  DataHandleModuleTests.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import XCTest
@testable import DataHandlerKit

final class DataHandleModuleTests: XCTestCase {
    
    // MARK: - Private fields
    
    private var firstNameEqualsSumHandlerMock = FirstNameEqualsSumHandlerMock(sumService: SumService())
    private var lastNameEqualsPriceHandlerMock = LastNameEqualsPriceHandlerMock(priceService: PriceService())
    private var ageEqualsDeliveriesHandlerMock = AgeEqualsDeliveriesHandlerMock(deliveriesService: DeliveriesService())
    private var firstAndLastNameEqualsDiscountHandlerMock = FirstAndLastNameEqualsDiscountHandlerMock(discountService: DiscountService())
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsWithFirstNameThenCorrectHandlerDidCall() throws {
        let testObject = generateTestObject()
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(firstNameEqualsSumHandlerMock.handlePersonsCalls, 1)
    }
    
    func testWhenCallHandlePersonsWithFirstNameThenOthersHandlersDidNotCall() throws {
        let testObject = generateTestObject()
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(lastNameEqualsPriceHandlerMock.handlePersonsCalls, 0)
        XCTAssertEqual(ageEqualsDeliveriesHandlerMock.handlePersonsCalls, 0)
        XCTAssertEqual(firstAndLastNameEqualsDiscountHandlerMock.handlePersonsCalls, 0)
    }
    
    func testWhenCallHandlePersonsWithAgeThenCorrectHandlerDidCall() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "Jonny", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(ageEqualsDeliveriesHandlerMock.handlePersonsCalls, 1)
    }
    
    func testWhenCallHandlePersonsWithAgeThenOthersHandlersDidNotCall() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "Jonny", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(lastNameEqualsPriceHandlerMock.handlePersonsCalls, 0)
        XCTAssertEqual(firstAndLastNameEqualsDiscountHandlerMock.handlePersonsCalls, 0)
    }
    
    func testWhenCallHandlePersonsWithLastNameThenCorrectHandlerDidCall() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        ageEqualsDeliveriesHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 43),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "Jonny", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(lastNameEqualsPriceHandlerMock.handlePersonsCalls, 1)
    }
    
    func testWhenCallHandlePersonsWithLastNameThenOthersHandlersDidCall() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        ageEqualsDeliveriesHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 43),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "Jonny", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertEqual(firstNameEqualsSumHandlerMock.handlePersonsCalls, 1)
        XCTAssertEqual(ageEqualsDeliveriesHandlerMock.handlePersonsCalls, 1)
        XCTAssertEqual(lastNameEqualsPriceHandlerMock.handlePersonsCalls, 1)
    }
    
    func testWhenCallHandlePersonsThenFirstNameEqualsSumHandlerCalledWithParams() throws {
        let testObject = generateTestObject()
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertTrue(firstNameEqualsSumHandlerMock.handlePersonsCalls > 0)
        XCTAssertEqual(firstNameEqualsSumHandlerMock.params as? [String], ["John"])
    }
    
    func testWhenCallHandlePersonsWithAgeThenEqualsDeliveriesHandlerCalledWithParams() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertTrue(ageEqualsDeliveriesHandlerMock.handlePersonsCalls > 0)
        XCTAssertEqual(ageEqualsDeliveriesHandlerMock.params as? [Int], [23])
    }
    
    func testWhenCallHandlePersonsThenLastNameEqualsPriceHandlerCalledWithParams() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        ageEqualsDeliveriesHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertTrue(lastNameEqualsPriceHandlerMock.handlePersonsCalls > 0)
        XCTAssertEqual(lastNameEqualsPriceHandlerMock.params as? [String], ["Smith"])
    }
    
    func testWhenCallHandlePersonsThenFirstAndLastNameEqualsDiscountHandlerCalledWithParams() throws {
        let testObject = generateTestObject()
        firstNameEqualsSumHandlerMock.predefinedResult = .skipped
        ageEqualsDeliveriesHandlerMock.predefinedResult = .skipped
        lastNameEqualsPriceHandlerMock.predefinedResult = .skipped
        let dataSet = [
            Person(firstName: "Jenifer", lastName: "Radrigues", age: 23),
            Person(firstName: "Robert", lastName: "Martin", age: 33),
            Person(firstName: "John", lastName: "Smith", age: 35)
        ]
        
        testObject.handle(employees: dataSet)
        
        XCTAssertTrue(firstAndLastNameEqualsDiscountHandlerMock.handlePersonsCalls > 0)
        XCTAssertEqual(firstAndLastNameEqualsDiscountHandlerMock.params as? [String], ["Robert", "Martin"])
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> DataHandleModule {
        firstNameEqualsSumHandlerMock = FirstNameEqualsSumHandlerMock(sumService: SumService())
        lastNameEqualsPriceHandlerMock = LastNameEqualsPriceHandlerMock(priceService: PriceService())
        ageEqualsDeliveriesHandlerMock = AgeEqualsDeliveriesHandlerMock(deliveriesService: DeliveriesService())
        firstAndLastNameEqualsDiscountHandlerMock = FirstAndLastNameEqualsDiscountHandlerMock(discountService: DiscountService())
        
        return DataHandleModule(
            firstNameEqualsSumHandler: firstNameEqualsSumHandlerMock,
            lastNameEqualsPriceHandler: lastNameEqualsPriceHandlerMock,
            ageEqualsDeliveriesHandler: ageEqualsDeliveriesHandlerMock,
            firstAndLastNameEqualsDiscountHandler: firstAndLastNameEqualsDiscountHandlerMock
        )
    }
}

fileprivate final class FirstNameEqualsSumHandlerMock: FirstNameEqualsSumHandler {
    
    // MARK: - Public fields
    
    var predefinedResult: HandleActionResult?
    
    private(set) var handlePersonsCalls = 0
    private(set) var params: [Any] = []
    
    // MARK: - Override functions
    
    override func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        self.params = params
        handlePersonsCalls += 1
        if let predefinedResult = predefinedResult {
            return predefinedResult
        }
        return .processed
    }
}

fileprivate final class LastNameEqualsPriceHandlerMock: LastNameEqualsPriceHandler {
    
    // MARK: - Public fields
    
    var predefinedResult: HandleActionResult?
    
    private(set) var handlePersonsCalls = 0
    private(set) var params: [Any] = []
    
    // MARK: - Override functions
    
    override func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        self.params = params
        handlePersonsCalls += 1
        if let predefinedResult = predefinedResult {
            return predefinedResult
        }
        return .processed
    }
}

fileprivate final class AgeEqualsDeliveriesHandlerMock: AgeEqualsDeliveriesHandler {
    
    // MARK: - Public fields
    
    var predefinedResult: HandleActionResult?
    
    private(set) var handlePersonsCalls = 0
    private(set) var params: [Any] = []
    
    // MARK: - Override functions
    
    override func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        self.params = params
        handlePersonsCalls += 1
        if let predefinedResult = predefinedResult {
            return predefinedResult
        }
        return .processed
    }
}

fileprivate final class FirstAndLastNameEqualsDiscountHandlerMock: FirstAndLastNameEqualsDiscountHandler {
    
    // MARK: - Public fields
    
    var predefinedResult: HandleActionResult?
    
    private(set) var handlePersonsCalls = 0
    private(set) var params: [Any] = []
    
    // MARK: - Override functions
    
    override func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        self.params = params
        handlePersonsCalls += 1
        if let predefinedResult = predefinedResult {
            return predefinedResult
        }
        return .processed
    }
}
