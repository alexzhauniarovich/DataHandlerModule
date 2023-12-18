//
//  ActionHandler.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

enum HandleActionResult {
    case processed, skipped, failed
}

protocol ActionHandler {
    
    func handlePersons(_ persons: [Person], params: [Any]) -> HandleActionResult
}
