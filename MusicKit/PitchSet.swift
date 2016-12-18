//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

// MARK: == PitchSet ==
/// A collection of unique `Pitch` instances ordered by frequency.
public struct PitchSet: Equatable {
    public typealias Index = Int
    public typealias Element = Pitch

    fileprivate var contents: [Element] = []
    /// Creates an empty `PitchSet`
    public init() { }

    /// Creates a new `PitchSet` with the contents of a given sequence of pitches.
    public init<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        contents = Set(sequence).sorted()
    }

    /// Creates a new `PitchSet` with the given pitches.
    public init(pitches: Element...) {
        self.init(pitches)
    }

    /// Returns the index of the given `pitch`
    ///
    /// :returns: The index of the first instance of `pitch`, or `nil` if `pitch` isn't found.
    public func index(of pitch: Element) -> Index? {
        let index = contents.insertionIndex(pitch)
        if index == count {
            return nil
        }
        return contents[index] == pitch ? index : nil
    }

    /// Returns true iff `pitch` is found in the collection.
    public func contains(_ pitch: Element) -> Bool {
        return index(of: pitch) != nil
    }


    /// Returns a new `PitchSet` with the combined contents of `self` and the given pitches.
    public func merge(_ pitches: Element...) -> PitchSet {
        return merge(pitches)
    }

    /// Returns a new `PitchSet` with the combined contents of `self` and the given sequence of pitches.
    public func merge<S: Sequence>(_ pitches: S) -> PitchSet where S.Iterator.Element == Element {
        return PitchSet(contents + pitches)
    }

    /// Inserts one or more new pitches into the `PitchSet` in the correct order.
    public mutating func insert(_ pitches: Element...) {
        for pitch in pitches {
            if !contains(pitch) {
                contents.insert(pitch, at: contents.insertionIndex(pitch))
            }
        }
    }

    /// Inserts the contents of a sequence of pitches into the `PitchSet`.
    public mutating func insert<S: Sequence>(_ pitches: S) where S.Iterator.Element == Pitch {
        contents = Set(contents + pitches).sorted()
    }

    /// Removes `pitch` from the `PitchSet` if it exists.
    ///
    /// :returns: The given pitch if found, otherwise `nil`.
    public mutating func remove(_ pitch: Element) -> Element? {
        return index(of: pitch).map {
            self.contents.remove(at: $0)
        }
    }

    /// Removes and returns the pitch at `index`. Requires count > 0.
    public mutating func remove(at index: Index) -> Element {
        return contents.remove(at: index)
    }

    /// Removes all pitches from the `PitchSet`.
    public mutating func removeAll(_ keepCapacity: Bool = true) {
        contents.removeAll(keepingCapacity: keepCapacity)
    }
}

// MARK: Printable
extension PitchSet: CustomStringConvertible {
    public var description: String {
        return contents.description
    }
}

// MARK: CollectionType
extension PitchSet: Collection {
    /// Returns the position immediately after the given index.
    public func index(after i: Index) -> Index {
      return i + 1
    }

    /// The position of the first pitch in the set. (Always zero.)
    public var startIndex: Index {
        return 0
    }

    /// One greater than the position of the last pitch in the set.
    /// Zero when the collection is empty.
    public var endIndex: Index {
        return contents.endIndex
    }

    /// Accesses the pitch at index `i`.
    /// Read-only to ensure sorting - use `insert` to add new pitches.
    public subscript(i: Index) -> Element {
        return contents[i]
    }

    /// Access the elements in the given range.
    public subscript(range: Range<Index>) -> PitchSetSlice {
        return PitchSetSlice(contents[range])
    }
}

// MARK: ArrayLiteralConvertible
extension PitchSet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.contents = Set(elements).sorted()
    }
}

extension PitchSet: BidirectionalCollection {
    public func index(before i: Index) -> Index {
        return i - 1
    }
}

// MARK: Equatable
public func ==(lhs: PitchSet, rhs: PitchSet) -> Bool {
    return lhs.count == rhs.count && lhs.elementsEqual(rhs)
}

// MARK: Operators
public func +(lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    var lhs = lhs
    lhs.insert(rhs)
    return lhs
}

public func +=(lhs: inout PitchSet, rhs: PitchSet) {
    lhs.insert(rhs)
}

public func -(lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    var lhs = lhs
    for pitch in rhs {
        _ =  lhs.remove(pitch)
    }
    return lhs
}

public func -=(lhs: inout PitchSet, rhs: PitchSet) {
    for pitch in rhs {
        _ =  lhs.remove(pitch)
    }
}

// MARK: == PitchSetSlice ==
/// A slice of a `PitchSet`.
public struct PitchSetSlice {
    public typealias Index = Int
    public typealias Element = Pitch
    fileprivate var contents: ArraySlice<Element> = []

    /// Creates an empty `PitchSetSlice`.
    public init() { }

    /// Creates a new `PitchSetSlice` with the contents of a given sequence.
    public init<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        contents = ArraySlice(Set(sequence).sorted())
    }

    /// Creates a new `PitchSetSlice` with the given values.
    public init(values: Element...) {
        contents = ArraySlice(Set(values).sorted())
    }

    /// Creates a new `PitchSetSlice` from a sorted slice.
    fileprivate init(sortedSlice: ArraySlice<Element>) {
        contents = sortedSlice
    }

    /// Returns the index of the given `pitch`
    ///
    /// :returns: The index of the first instance of `pitch`, or `nil` if `pitch` isn't found.
    public func index(of pitch: Element) -> Index? {
        let index = contents.insertionIndex(pitch)
        if index == count {
            return nil
        }
        return contents[index] == pitch ? index : nil
    }

    /// Returns true iff `pitch` is found in the slice.
    public func contains(_ pitch: Element) -> Bool {
        return index(of: pitch) != nil
    }

    /// Returns a new `PitchSetSlice` with the combined contents of `self` and the given pitches.
    public func merge(_ pitches: Element...) -> PitchSetSlice {
        return merge(pitches)
    }

    /// Returns a new `PitchSetSlice` with the combined contents of `self` and the given pitches.
    public func merge<S: Sequence>(_ pitches: S) -> PitchSetSlice where S.Iterator.Element == Pitch {
        return PitchSetSlice(contents + pitches)
    }

    /// Inserts one or more new pitches into the slice in the correct order.
    public mutating func insert(_ pitches: Element...) {
        for pitch in pitches {
            if !contains(pitch) {
                contents.insert(pitch, at: contents.insertionIndex(pitch))
            }
        }
    }

    /// Inserts the contents of a sequence into the `PitchSetSlice`.
    public mutating func insert<S: Sequence>(_ pitches: S) where S.Iterator.Element == Element {
        contents = ArraySlice(Set(contents + pitches).sorted())
    }

    /// Removes `pitch` from the slice if it exists.
    ///
    /// :returns: The given value if found, otherwise `nil`.
    public mutating func remove(_ pitch: Element) -> Element? {
        return index(of: pitch).map { contents.remove(at: $0) }
    }

    /// Removes and returns the pitch at `index`. Requires count > 0.
    public mutating func remove(at index: Index) -> Element {
        return contents.remove(at: index)
    }

    /// Removes all pitches from the slice.
    public mutating func removeAll(_ keepCapacity: Bool = true) {
        contents.removeAll(keepingCapacity: keepCapacity)
    }
}

// MARK: Printable
extension PitchSetSlice: CustomStringConvertible {
    public var description: String {
        return contents.description
    }
}

// MARK: CollectionType
extension PitchSetSlice: Collection {
    /// Returns the position immediately after the given index.
    public func index(after i: Index) -> Index {
      return i + 1
    }

    /// The position of the first pitch in the slice. (Always zero.)
    public var startIndex: Index {
        return 0
    }

    /// One greater than the position of the last element in the slice. Zero when the slice is empty.
    public var endIndex: Index {
        return count
    }

    /// Accesses the pitch at index `i`.
    ///
    /// Read-only to ensure sorting - use `insert` to add new pitches.
    public subscript(i: Index) -> Element {
        return contents[i]
    }

    /// Access the elements in the given range.
    public subscript(range: Range<Index>) -> PitchSetSlice {
        return PitchSetSlice(contents[range])
    }
}

extension PitchSetSlice: BidirectionalCollection {
    public func index(before i: Index) -> Index {
        return i - 1
    }
}

// MARK: ArrayLiteralConvertible
extension PitchSetSlice: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        contents = ArraySlice(Set(elements).sorted())
    }
}
