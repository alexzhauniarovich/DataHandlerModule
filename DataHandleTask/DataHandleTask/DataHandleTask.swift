//
//  DataHandleTask.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

import DataHandlerKit

@main
struct DataHandleTask {
    
    // MARK: - Public functions
    
    static func main() {
        DataHandleModule().handle(
            employees: [
                Person(firstName: "John", lastName: "Smith", age: 23),
                Person(firstName: "Robert", lastName: "Martin", age: 25)
            ]
        )
    }
}
