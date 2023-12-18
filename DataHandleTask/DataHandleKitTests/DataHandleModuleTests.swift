import XCTest
@testable import DataHandleModule

final class DataHandleModuleTests: XCTestCase {
    
    // MARK: - Private fields
    
    private lazy var firstNameEqualsSumHandlerMock: FirstNameEqualsSumHandlerMock
    private lazy var lastNameEqualsPriceHandler: LastNameEqualsPriceHandler
    private lazy var ageEqualsDeliveriesHandler: AgeEqualsDeliveriesHandler
    private lazy var firstAndLastNameEqualsDiscountHandler: FirstAndLastNameEqualsDiscountHandler
    
    // MARK: - Unit Test
    
    func testWhenCallHandlePersonsThenCorrectHandlersDidCall() throws {
        let testObject = generateTestObject()
        let employs = [
            Person(firstName: "FirstName", lastName: "LastName", age: 44),
            Person(firstName: "FirstName", lastName: "LastName", age: 20)
        ]
        
        testObject.handle(employs: employs)
        
        XCTAssertTrue(firstNameEqualsSumHandlerMock.handlePersonsCalls > 0)
        XCTAssertTrue(lastNameEqualsPriceHandler.handlePersonsCalls > 0)
        XCTAssertTrue(ageEqualsDeliveriesHandler.handlePersonsCalls > 0)
        XCTAssertTrue(firstAndLastNameEqualsDiscountHandler.handlePersonsCalls > 0)
    }
    
    func testWhenCallHandlePersonsThenHandlersDidCallOnce() throws {
        let testObject = generateTestObject()
        let employs = [
            Person(firstName: "FirstName", lastName: "LastName", age: 44),
            Person(firstName: "FirstName", lastName: "LastName", age: 20)
        ]
        
        testObject.handle(employs: employs)
        
        XCTAssertEqual(firstNameEqualsSumHandlerMock.handlePersonsCalls, 1)
        XCTAssertEqual(lastNameEqualsPriceHandler.handlePersonsCalls, 1)
        XCTAssertEqual(ageEqualsDeliveriesHandler.handlePersonsCalls, 1)
        XCTAssertEqual(firstAndLastNameEqualsDiscountHandler.handlePersonsCalls, 1)
    }
    
    // MARK: - Private functions
    
    private func generateTestObject() -> DataHandleModule {
        firstNameEqualsSumHandlerMock = FirstNameEqualsSumHandlerMock()
        lastNameEqualsPriceHandler = LastNameEqualsPriceHandler()
        ageEqualsDeliveriesHandler = AgeEqualsDeliveriesHandler()
        firstAndLastNameEqualsDiscountHandler = FirstAndLastNameEqualsDiscountHandler()
        
        return DataHandleModule(
            firstNameEqualsSumHandler: firstNameEqualsSumHandlerMock,
            lastNameEqualsPriceHandler: lastNameEqualsPriceHandler,
            ageEqualsDeliveriesHandler: ageEqualsDeliveriesHandler,
            firstAndLastNameEqualsDiscountHandler: firstAndLastNameEqualsDiscountHandler
        )
    }
}

fileprivate class FirstNameEqualsSumHandlerMock: FirstNameEqualsSumHandler {
    
    // MARK: - Public fields
    
    var handlePersonsCalls = 0
    
    // MARK: - Override functions
    
    override func handlePersons() {
        handlePersonsCalls += 1
    }
}

fileprivate class LastNameEqualsPriceHandlerMock: LastNameEqualsPriceHandler {
    
    // MARK: - Public fields
    
    var handlePersonsCalls = 0
    
    // MARK: - Override functions
    
    override func handlePersons() {
        handlePersonsCalls += 1
    }
}

fileprivate class AgeEqualsDeliveriesHandlerMock: AgeEqualsDeliveriesHandler {
    
    // MARK: - Public fields
    
    var handlePersonsCalls = 0
    
    // MARK: - Override functions
    
    override func handlePersons() {
        handlePersonsCalls += 1
    }
}

fileprivate class FirstAndLastNameEqualsDiscountHandlerMock: FirstAndLastNameEqualsDiscountHandler {
    
    // MARK: - Public fields
    
    var handlePersonsCalls = 0
    
    // MARK: - Override functions
    
    override func handlePersons() {
        handlePersonsCalls += 1
    }
}
