//
//  DataHandleModule.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

private enum Constants {
    static let firstNameJohn = "John"
    static let firstNameRobert = "Robert"
    static let lastNameMartin = "Martin"
    static let lastNameSmith = "Smith"
    static let requiredAge = 23
}

public final class DataHandleModule {
    
    // MARK: - Private fields
    
    private let firstNameEqualsSumHandler: FirstNameEqualsSumHandler
    private let lastNameEqualsPriceHandler: LastNameEqualsPriceHandler
    private let ageEqualsDeliveriesHandler: AgeEqualsDeliveriesHandler
    private let firstAndLastNameEqualsDiscountHandler: FirstAndLastNameEqualsDiscountHandler
    
    // MARK: - Initialisation
    
    init(
        firstNameEqualsSumHandler: FirstNameEqualsSumHandler,
        lastNameEqualsPriceHandler: LastNameEqualsPriceHandler,
        ageEqualsDeliveriesHandler: AgeEqualsDeliveriesHandler,
        firstAndLastNameEqualsDiscountHandler: FirstAndLastNameEqualsDiscountHandler
    ) {
        self.firstNameEqualsSumHandler = firstNameEqualsSumHandler
        self.lastNameEqualsPriceHandler = lastNameEqualsPriceHandler
        self.ageEqualsDeliveriesHandler = ageEqualsDeliveriesHandler
        self.firstAndLastNameEqualsDiscountHandler = firstAndLastNameEqualsDiscountHandler
    }
    
    public convenience init() {
        let graph = DependenciesGraph.sharedInstance
        self.init(
            firstNameEqualsSumHandler: graph.prepareFirstNameEqualsSumHandler(),
            lastNameEqualsPriceHandler: graph.prepareLastNameEqualsPriceHandler(),
            ageEqualsDeliveriesHandler: graph.prepareAgeEqualsDeliveriesHandler(),
            firstAndLastNameEqualsDiscountHandler: graph.prepareFirstAndLastNameEqualsDiscountHandler()
        )
    }
    
    // MARK: - Public functions
    
    public func handle(employees: [Person]) {
        basicEmployeesHandling(employees)
    }
    
    // MARK: - Private functions
    
    private func basicEmployeesHandling(_ employees: [Person]) {
        guard firstNameEqualsSumHandler.handlePersons(employees, params: [Constants.firstNameJohn]) != .processed
        else { return }
        
        guard ageEqualsDeliveriesHandler.handlePersons(employees, params: [Constants.requiredAge]) != .processed
        else { return }
        
        guard lastNameEqualsPriceHandler.handlePersons(employees, params: [Constants.lastNameSmith]) != .processed
        else { return }
                
        _ = firstAndLastNameEqualsDiscountHandler.handlePersons(employees, params: [Constants.firstNameRobert, Constants.lastNameMartin])
    }
}
