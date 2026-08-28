# Tagged Collection

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Re-exposes an institute collection through a phantom-typed index — `Tagged<Tag, Underlying>` indexes by `Index<Tag>` instead of `Index<Element>`, so positions from one collection can never be confused with another's.

---

## Quick Start

This package is a single, generic bridge between the atom-owned `Tagged`, `Collection`, and `Index` domains. When `Tagged`'s `Underlying` is a collection whose index domain is `Index<Element>`, `Tagged<Tag, Underlying>` re-exposes that collection through `Index<Tag>`. The phantom `Tag` distinguishes this collection's positions from any other's, caught at compile time rather than runtime.

```swift
import Tagged_Collection

enum Node {}

// Any `Collection.Protocol` conformer whose Index is `Index<Element>`.
// Assume MyIndexedCollection conforms to Collection.Protocol with Index<Int> positions.
let source = MyIndexedCollection([10, 20, 30])

// `Tagged<Node, …>` re-exposes the collection through `Index<Node>`.
let nodes = Tagged<Node, MyIndexedCollection<Int>>(_unchecked: source)

#expect(!nodes.isEmpty)

var collected: [Int] = []
var i = nodes.startIndex
while i < nodes.endIndex {
    collected.append(nodes[i])      // subscript by Index<Node>, not Index<Int>
    i = nodes.index(after: i)
}
// collected == [10, 20, 30]
```

The bridge is a read-only view: `Tagged.underlying` is `package(set)`, so the subscript cannot write through it from a consumer. The mechanism is `Tagged`'s own `retag`, applied to the `Tagged`-based `Index` (`Index<T> == Tagged<T, Ordinal>`) — it is the single generic replacement for per-container `*.Indexed<Tag>` wrappers. Mutable consumers keep a plain collection and `retag` at the call site.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-tagged-collection.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Tagged Collection", package: "swift-tagged-collection"),
    ]
)
```

Requires Swift 6.4 and macOS 27 / iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product plus a narrow test-support re-export. The package is pure integration — it adds a single generic extension on `Tagged` and re-exports its three production dependencies.

| Product | Target | Purpose |
|---------|--------|---------|
| `Tagged Collection` | `Sources/Tagged Collection/` | The phantom-typed indexed-collection view: an extension on `Tagged` exposing `count`, `isEmpty`, `startIndex`, `endIndex`, `index(after:)`, and `subscript(position:)` in the `Index<Tag>` domain. Re-exports the current `Tagged`, `Collection`, and `Index` owners. |
| `Tagged Collection Test Support` | `Tests/Support/` | Narrow re-export of the main target for test consumers. |

Production dependencies: [swift-tagged](https://github.com/swift-atoms/swift-tagged), [swift-collection](https://github.com/swift-atoms/swift-collection), [swift-index](https://github.com/swift-atoms/swift-index).

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 27 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
