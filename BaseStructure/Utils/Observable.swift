//
//  Observable.swift
//  BaseStructure
//
//  Created by Gaurang on 03/05/22.
//

import Foundation
class Observable<T> {

    private var value: T {
        didSet {
            action?(value)
        }
    }

    typealias Action = (T) -> Void

    private var action: Action?

    init(value: T) {
        self.value = value
    }

    func set(_ value: T) {
        self.value = value
    }

    func bind(action: @escaping Action) {
        self.action = action
    }
}
