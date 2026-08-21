public import Collection_Protocol_Primitives
public import Index_Primitives
public import Tagged_Primitives

extension Tagged
where
    Tag: ~Copyable & ~Escapable,
    Underlying: Collection.`Protocol`,
    Underlying.Element: Copyable,
    Underlying.Index == Index_Primitives.Index<Underlying.Element>
{

    public var count: Index_Primitives.Index<Tag>.Count {
        underlying.count.retag(Tag.self)
    }

    public var isEmpty: Bool {
        underlying.isEmpty
    }

    public var startIndex: Index_Primitives.Index<Tag> {
        underlying.startIndex.retag(Tag.self)
    }

    public var endIndex: Index_Primitives.Index<Tag> {
        underlying.endIndex.retag(Tag.self)
    }

    public func index(after i: Index_Primitives.Index<Tag>) -> Index_Primitives.Index<Tag> {
        underlying.index(after: i.retag(Underlying.Element.self)).retag(Tag.self)
    }

    public subscript(position: Index_Primitives.Index<Tag>) -> Underlying.Element {
        underlying[position.retag(Underlying.Element.self)]
    }
}
