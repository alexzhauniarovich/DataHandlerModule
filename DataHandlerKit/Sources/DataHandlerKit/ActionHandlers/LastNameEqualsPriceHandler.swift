//
//  LastNameEqualsPriceHandler.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

class LastNameEqualsPriceHandler: ActionHandler {
    
    // MARK: - Private fields
    
    private let priceService: PriceService
    
    // MARK: - Initialisation
    
    init(priceService: PriceService) {
        self.priceService = priceService
    }
    
    // MARK: - Public functions
    
    func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        guard let lastNameParam = params.first as? String else { return .failed }
        
        if persons.first(where: { $0.lastName == lastNameParam }) != nil {
            priceService.priceCalculation()
            return .processed
        }
        return .skipped
    }
}
