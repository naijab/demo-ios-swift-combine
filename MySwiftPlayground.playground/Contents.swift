import Combine
import Foundation

//print("=== Just -> Map -> Sink ===")

// Produce
let worker1 = Just("data 1")
let worker2 = Just("data 2")

// Operator
let withMap1 = worker1.map { "From Operator 1 --> \($0)"}
let withMap2 = worker2.map { "From Operator 2 --> \($0)"}

// Output
withMap1.sink { print($0) }
withMap2.sink { print($0) }

//print("\n=== CombineLatest -> Sink ===")

// Produce
let combineLatestEx = worker1.combineLatest(worker2)

// Output
combineLatestEx.sink { print($0) }
