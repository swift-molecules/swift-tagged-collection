public import Collection
public import Index
internal import Ordinal_Comparison
public import Tagged

extension Tagged
where
    Tag: ~Copyable & ~Escapable,
    Underlying: Collection.`Protocol`,
    Underlying.Element: Copyable,
    Underlying.Index == Index<Underlying.Element>
{

    public var count: Int {
        underlying.count
    }

    public var isEmpty: Bool {
        underlying.isEmpty
    }

    public var startIndex: Index<Tag> {
        underlying.startIndex.retag(Tag.self)
    }

    public var endIndex: Index<Tag> {
        underlying.endIndex.retag(Tag.self)
    }

    public func index(after i: Index<Tag>) -> Index<Tag> {
        underlying.index(after: i.retag(Underlying.Element.self)).retag(Tag.self)
    }

    public subscript(position: Index<Tag>) -> Underlying.Element {
        underlying[position.retag(Underlying.Element.self)]
    }
}
