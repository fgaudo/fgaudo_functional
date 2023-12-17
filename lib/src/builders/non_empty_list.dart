import '../non_empty_list.dart' as NEL;

final class NonEmptyListBuilder<A> {
  const NonEmptyListBuilder(this._list);

  final NEL.NonEmptyList<A> _list;

  NEL.NonEmptyList<A> build() => _list;

  int get length => NEL.length(_list);

  NonEmptyListBuilder<B> map<B>(B Function(A) f) =>
      NonEmptyListBuilder(NEL.map(f)(_list));

  B reduce<B>(B b, B Function(B, A) f) => NEL.reduce(b, f)(_list);
}

extension ToBuilderNonEmptyListExtension<A> on NEL.NonEmptyList<A> {
  NonEmptyListBuilder<A> toBuilder() => NonEmptyListBuilder(this);
}
