//
//  AgeEqualsDeliveriesHandler.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

class AgeEqualsDeliveriesHandler: ActionHandler {
    
    // MARK: - Private fields
    
    private let deliveriesService: DeliveriesService
    
    // MARK: - Initialisation
    
    init(deliveriesService: DeliveriesService) {
        self.deliveriesService = deliveriesService
    }
    
    // MARK: - Public functions
    
    func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult {
        guard let ageParam = params.first as? Int else { return .failed }
        
        if persons.first(where: { $0.age == ageParam }) != nil {
            deliveriesService.deliveriesCalculation()
            return .processed
        }
        return .skipped
    }
}
