//
//  Dynamic.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/9/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

public class Dynamic<T> {
    public typealias Listener = (T) -> ()
    
    public var listeners: [Listener] = []
    
    public func bind(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    public func bindAndFire(_ listener: @escaping Listener) {
        listeners.append(listener)
        fire(for: value)
    }
    
    private func fire(for value: T) {
        listeners.forEach { $0(value) }
    }
    
    public var value: T {
        didSet {
            fire(for: value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
}

