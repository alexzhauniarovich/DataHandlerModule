//
//  Person.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

public struct Person {
    
    public var firstName: String
    public var lastName: String
    public var age: Int
    
    // MARK: - Initialisation
    
    public init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}
