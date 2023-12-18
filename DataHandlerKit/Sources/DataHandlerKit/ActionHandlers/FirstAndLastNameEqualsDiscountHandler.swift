//
//  FirstAndLastNameEqualsDiscountHandler.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

class FirstAndLastNameEqualsDiscountHandler: ActionHandler {
    
    // MARK: - Private fields
    
    private let discountService: DiscountService
    
    // MARK: - Initialisation
    
    init(discountService: DiscountService) {
        self.discountService = discountService
    }
    
    // MARK: - Public functions
    
    func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        guard let firstNameParam = params.first as? String,
             let lastNameParam = params.last as? String
        else { return .failed }
        
        let person = persons.first(where: {
            $0.firstName == firstNameParam && $0.lastName == lastNameParam
        })
        if person != nil { 
            discountService.discountCalculation()
            return .processed
        }
        
        return .skipped
    }
}
