//
//  Functional.swift
//  JSON
//
//  Created by David Owens II on 8/5/14.
//  Copyright (c) 2014 David Owens II. All rights reserved.
//

infix operator ⇒ { associativity left precedence 150 }

/// Allows for a transformative function to be applied to a value, allowing for optionals.
///
/// :param: lhs The transformative function
/// :param: rhs The value to apply to the function
/// :returns: The transformation of `rhs` using `lhs`.
public func ⇒ <A, B>(lhs: (A -> B)?, rhs: A?) -> B? {
    if let lhs = lhs {
        if let rhs = rhs {
            return lhs(rhs)
        }
    }
    
    return nil
}

/// Allows for a value to be transformed by a function, allowing for optionals.
///
/// :param: lhs The value to apply to the function
/// :param: rhs The transformative function
/// :returns: The transformation of `lhs` using `rhs`.
public func ⇒ <A, B>(lhs: A?, rhs: (A -> B)?) -> B? {
    if let lhs = lhs {
        if let rhs = rhs {
            return rhs(lhs)
        }
    }
    
    return nil
}

/// Allows for a transformative function to be applied to a value.
///
/// :param: lhs The transformative function
/// :param: rhs The value to apply to the function
/// :returns: The transformation of `rhs` using `lhs`.
public func ⇒ <A, B>(lhs: A -> B, rhs: A) -> B { return lhs(rhs) }


/// Allows for a value to be transformed by a function.
///
/// :param: lhs The value to apply to the function
/// :param: rhs The transformative function
/// :returns: The transformation of `lhs` using `rhs`.
public func ⇒ <A, B>(lhs: A, rhs: A -> B) -> B { return rhs(lhs) }
