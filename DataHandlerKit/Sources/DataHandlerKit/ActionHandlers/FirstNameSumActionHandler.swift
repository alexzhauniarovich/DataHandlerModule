//
//  FirstNameEqualsSumHandler.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

class FirstNameEqualsSumHandler: ActionHandler {
    
    // MARK: - Private fields
    
    private let sumService: SumService
    
    // MARK: - Initialisation
    
    init(sumService: SumService) {
        self.sumService = sumService
    }
    
    // MARK: - Public functions
    
    func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        guard let firstNameParam = params.first as? String else { return .failed }
        
        if persons.first(where: { $0.firstName == firstNameParam }) != nil {
            sumService.sumCalculation()
            return .processed
        }
        return .skipped
    }
}
