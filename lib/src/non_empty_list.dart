import '../option.dart';

final class NonEmptyList<A> {
  const NonEmptyList(this.head, this.tail);

  final A head;
  final List<A> tail;
}

List<A> toList<A>(NonEmptyList<A> list) => [list.head, ...list.tail];

int length(NonEmptyList<dynamic> list) => list.tail.length + 1;

NonEmptyList<B> Function(
  NonEmptyList<A>,
) map<A, B>(B Function(A) f) => (list) => NonEmptyList(
      f(list.head),
      list.tail.map(f).toList(),
    );

B Function(
  NonEmptyList<A>,
) reduce<A, B>(B b, B Function(B, A) f) =>
    (list) => list.tail.fold(f(b, list.head), f);
