//
//  Extensions.swift
//  MusicKit
//
//  Created by Adam Nemecek on 12/17/16.
//  Copyright © 2016 benzguo. All rights reserved.
//

import Foundation

extension Sequence {
    public func scan<T>(_ initial: T, _ combine: (T, Iterator.Element) throws -> T) rethrows -> [T] {
        var accu = initial
        return try map {
            accu = try combine(accu, $0)
            return accu
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    var unique: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { s.insert($0).inserted }
    }

    var duplicates: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { !s.insert($0).inserted }
    }
}



extension Sequence where SubSequence: Sequence {
    var tuples: AnyIterator<(SubSequence.Iterator.Element, SubSequence.Iterator.Element)> {
        let i = zip(dropFirst(), dropLast())
        return AnyIterator(i.makeIterator())
    }
}
