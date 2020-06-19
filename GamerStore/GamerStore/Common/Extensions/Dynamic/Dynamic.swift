//
//  Dynamic.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

/// This is a simple class which allows binding without actually using a 3rd party, it is used for just
/// one simple use case which is, u are binding a property in a layer with another on the same thread in
/// a one way, meaning that u just come to one layer and bind it to the other (i prefer the UI to the presentation)
/// however, two way binding and binding while the two properties are not on the same thread, would break the app
/// how would it break the app?
/// two way binding would make an infinite loop of each property in both layers are setting each other one after another
/// if we used bind from a thread, then we are actually... well,
/// dealing with bits and bytes being modified, so u get a really unexpected results
class Dynamic<T> {
    
    var bind: (T) -> Void = { _ in }
    
    var value :T? {
        didSet {
            guard let value = value else { return }
            bind(value)
        }
    }
    
    init(_ v :T) {
        value = v
    }
    
}
