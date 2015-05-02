//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// A collection of unique `Pitch` instances ordered by frequency.
/// TODO: implement Sliceable
/// reference: https://github.com/natecook1000/SortedCollection/blob/master/SortedCollection/SortedCollection.swift
public struct PitchSet : Equatable {

    private var contents : [Pitch] = []
    var pitchToBool : [Pitch : Bool] = [:]

    /// The number of pitches the `PitchSet` contains.
    public var count: Int {
        return contents.count
    }

    /// Creates an empty `PitchSet`
    public init() { }

    /// Create a new `PitchSet` with the contents of a given sequence of pitches.
    public init<S : SequenceType where S.Generator.Element == Pitch>(_ sequence: S) {
        contents = sorted(sequence)
    }

    /// Create a new `PitchSet` with the given pitches.
    public init(values: Pitch...) {
        contents = sorted(values)
    }

    /// Returns the index of the given `pitch`
    ///
    /// :returns: The index of the first instance of `pitch`, or `nil` if `pitch` isn't found.
    public func indexOf(pitch: Pitch) -> Int? {
        let index = _insertionIndex(contents, pitch)
        if index == count {
            return nil
        }
        return contents[index] == pitch ? index : nil
    }

    /// Returns a new `PitchSet` with the combined contents of `self` and the given pitches.
    public func merge(pitches: Pitch...) -> PitchSet {
        return merge(pitches)
    }

    /// Returns a new `PitchSet` with the combined contents of `self` and the given sequence of pitches.
    public func merge<S: SequenceType where S.Generator.Element == Pitch>(pitches: S) -> PitchSet {
        return PitchSet(contents + pitches)
    }

    /// Inserts one or more new pitches into the `PItchSet` in the correct order.
    public mutating func insert(pitches: Pitch...) {
        for pitch in pitches {
            contents.insert(pitch, atIndex: _insertionIndex(contents, pitch))
        }
    }

    /// Inserts the contents of a sequence of pitches into the `PitchSet`.
    public mutating func insert<S: SequenceType where S.Generator.Element == Pitch>(pitches: S) {
        contents = sorted(contents + pitches)
    }

    /// Removes `pitch` from the `PitchSet` if it exists.
    ///
    /// :returns: The given pitch if found, otherwise `nil`.
    public mutating func remove(pitch: Pitch) -> Pitch? {
        if let index = indexOf(pitch) {
            return contents.removeAtIndex(index)
        }
        return nil
    }

    /// Removes and returns the pitch at `index`. Requires count > 0.
    public mutating func removeAtIndex(index: Int) -> Pitch {
        return contents.removeAtIndex(index)
    }

    /// Removes all elements from the `PitchSet`.
    public mutating func removeAll(keepCapacity: Bool = true) {
        contents.removeAll(keepCapacity: keepCapacity)
    }
}

// MARK: SequenceType
extension PitchSet : SequenceType {
    /// Returns a generator of the elements of the collection.
    public func generate() -> GeneratorOf<Pitch> {
        return GeneratorOf(contents.generate())
    }
}

// MARK: CollectionType
extension PitchSet : CollectionType {
    /// The position of the first pitch in the collection. (Always zero.)
    public var startIndex: Int {
        return 0
    }

    /// One greater than the position of the last element in the collection. 
    /// Zero when the collection is empty.
    public var endIndex: Int {
        return count
    }

    /// Accesses the pitch at index `i`.
    /// Read-only to ensure sorting - use `insert` to add new elements.
    public subscript(i: Int) -> Pitch {
        return contents[i]
    }
}

// MARK: ArrayLiteralConvertible
extension PitchSet : ArrayLiteralConvertible {
    public init(arrayLiteral elements: Pitch...) {
        self.contents = sorted(elements)
    }
}

// MARK: Printable
extension PitchSet : Printable {
    public var description : String {
        return contents.description
    }
}

// MARK: Gamut
extension PitchSet {
    /// Returns the set of pitch classes contained in the `PitchSet`
    public func gamut() -> Set<PitchClass> {
        var set = Set<PitchClass>()
        for pitch in self.contents {
            pitch.pitchClass.map { set.insert($0) }
        }
        return set
    }
}

// MARK: Harmonizer
extension PitchSet {
    /// Returns a harmonizer representation of this pitch set
    public func harmonizer() -> Harmonizer {
        return MusicKit.IdentityHarmonizer
    }

    /// Returns a harmonizer representation of this pitch set,
    /// transposed by the given scale and degree
    public func harmonizer(scale: Harmonizer, degree: Float) -> Harmonizer {
        // TODO: implement
        return MusicKit.IdentityHarmonizer
    }
}

// MARK: Equatable
public func ==(lhs: PitchSet, rhs: PitchSet) -> Bool {
    return lhs.contents == rhs.contents
}

// MARK: Operators
public func -(lhs: PitchSet, rhs: PitchSet) -> PitchSet { return lhs - rhs }
public func +(lhs: PitchSet, rhs: PitchSet) -> PitchSet { return lhs + rhs }

public func -=(inout lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    lhs -= rhs
    return lhs
}

public func +=(inout lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    lhs += rhs
    return lhs
}

public func +(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    lhs.insert(rhs)
    return lhs
}

public func +=(inout lhs: PitchSet, rhs: Pitch) -> PitchSet {
    lhs.insert(rhs)
    return lhs
}

public func -(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    lhs.remove(rhs)
    return lhs
}

public func -=(inout lhs: PitchSet, rhs: Pitch) -> PitchSet {
    lhs.remove(rhs)
    return lhs
}

public func /(lhs: PitchSet, rhs: PitchClass) -> PitchSet {
    if lhs.count == 0 {
        return lhs
    }
    var lhs = lhs
    let firstPitch = lhs[0]
    if firstPitch.pitchClass == nil {
        return lhs
    }
    var newFirstPitch = firstPitch
    while (newFirstPitch.pitchClass.map { $0 == rhs } != Optional(true)) {
        newFirstPitch = Pitch(midi: newFirstPitch.midi - 1)
    }
    lhs.insert(newFirstPitch)
    return lhs
}

// MARK: _insertionIndex
/// Returns the insertion point for `pitch` in the array of `pitches`.
///
/// If `pitch` exists at least once in `pitches`, the returned index will point to the
/// first instance of `pitch`. Otherwise, it will point to the location where `pitch`
/// could be inserted, keeping `pitchSet` in order.
///
/// :returns: An index in the range `0...count(pitches)` where `pitch` can be inserted.
private func _insertionIndex(pitches: [Pitch], pitch: Pitch) -> Int
{
    if isEmpty(pitches) {
        return 0
    }

    var (low, high) = (0, pitches.endIndex - 1)
    var mid = 0

    while low < high {
        mid = (high - low) / 2 + low
        if pitches[mid] < pitch {
            low = mid + 1
        } else {
            high = mid
        }
    }

    if pitches[low] >= pitch {
        return low
    }

    return pitches.endIndex
}


