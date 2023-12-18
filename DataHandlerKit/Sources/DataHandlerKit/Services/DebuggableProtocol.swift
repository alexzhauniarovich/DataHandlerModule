//
//  Debuggable.swift
//
//  Created by Alex Zhauniarovich on 16.12.23.
//

protocol Debuggable { }

extension Debuggable {
    
    func debug(_ function: String) {
        print(function, "called")
    }
}
