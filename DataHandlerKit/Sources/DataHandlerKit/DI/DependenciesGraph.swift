//
//  DependenciesGraph.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

final class DependenciesGraph {
    
    // MARK: - Public fields
    
    static var sharedInstance: DependenciesGraph {
        if let instance = instance {
            return instance
            
        } else {
            let dependenciesGraph = DependenciesGraph()
            instance = dependenciesGraph
            return dependenciesGraph
        }
    }
    
    // MARK: - Private fields
    
    private static var instance: DependenciesGraph?
    
    // MARK: - Initialisation
    
    private init() { }
    
    // MARK: - Public functions
    
    func prepareFirstNameEqualsSumHandler() -> FirstNameEqualsSumHandler {
        FirstNameEqualsSumHandler(sumService: getSumService())
    }
    
    func prepareLastNameEqualsPriceHandler() -> LastNameEqualsPriceHandler {
        LastNameEqualsPriceHandler(priceService: getPriceService())
    }
    
    func prepareAgeEqualsDeliveriesHandler() -> AgeEqualsDeliveriesHandler {
        AgeEqualsDeliveriesHandler(deliveriesService: getDeliveriesService())
    }
    
    func prepareFirstAndLastNameEqualsDiscountHandler() -> FirstAndLastNameEqualsDiscountHandler {
        FirstAndLastNameEqualsDiscountHandler(discountService: getDiscountService())
    }
}

// MARK: - Services

private extension DependenciesGraph {
    
    func getSumService() -> SumService {
        SumService()
    }
    
    func getDeliveriesService() -> DeliveriesService {
        DeliveriesService()
    }
    
    func getPriceService() -> PriceService {
        PriceService()
    }
    
    func getDiscountService() -> DiscountService {
        DiscountService()
    }
}
