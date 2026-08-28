import Collection
import Index
import Iterator
import Ordinal
import Tagged_Collection
import Tagged
import Testing

private enum Node {}

private typealias ElementIndex<Element: ~Copyable & ~Escapable> = Index<Element>
private typealias SourceIterator<Element: Copyable> = Iterator.Chunk<Element>

private struct IndexedSource<Value: Sendable>: Collection.`Protocol`, Sendable {
    let elements: [Value]

    init(_ elements: [Value]) {
        self.elements = elements
    }

    typealias Element = Value

    typealias Index = ElementIndex<Value>

    var startIndex: Index { Index(_unchecked: Ordinal(0)) }

    var endIndex: Index { Index(_unchecked: Ordinal(UInt(elements.count))) }

    subscript(position: Index) -> Value {
        elements[Int(position.underlying.rawValue)]
    }

    func index(after i: Index) -> Index {
        Index(_unchecked: Ordinal(i.underlying.rawValue + 1))
    }

    @_lifetime(borrow self)
    borrowing func makeIterator() -> SourceIterator<Value> {
        SourceIterator(elements.span)
    }
}

@Suite struct `Tagged Indexed View Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Tagged Indexed View Tests`.Unit {

    @Test func `indexed view over a collection conformer`() {
        let source = IndexedSource([10, 20, 30])
        let nodes = Tagged<Node, IndexedSource<Int>>(_unchecked: source)

        #expect(!nodes.isEmpty)

        var collected: [Int] = []
        var i = nodes.startIndex
        while i < nodes.endIndex {
            collected.append(nodes[i])
            i = nodes.index(after: i)
        }
        #expect(collected == [10, 20, 30])
    }
}
