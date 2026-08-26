import Collection_Test_Support
import Index
import Tagged_Collection
import Tagged
import Testing

private enum Node {}

@Suite struct `Tagged Indexed View Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Tagged Indexed View Tests`.Unit {

    @Test func `indexed view over a collection conformer`() {
        let source = Collection.Fixture.Source<Int>([10, 20, 30])
        let nodes = Tagged<Node, Collection.Fixture.Source<Int>>(source)

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
