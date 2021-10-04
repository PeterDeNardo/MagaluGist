//
//  Bindable.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import Foundation

class Bindable<T> {
    typealias BindType = ((T) -> Void)
    
    private var binds: [BindType] = []
    
    var value: T {
        didSet {
            execBinds()
        }
    }
    
    init(_ val: T) {
        value = val
    }
    
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip {
            return
        }
        bind(value)
    }
    
    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
