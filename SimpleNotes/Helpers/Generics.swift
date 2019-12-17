//
//  Generics.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class DynamicValueList<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    
    func add(object: T){
        data.value.append(object)
    }
    
    func addAll(object: [T]){
        data.value.append(contentsOf: object)
    }
    
    func remove(at: Int){
        data.value.remove(at: at)
    }
    
    func removeAll(){
        data.value.removeAll()
    }
}
