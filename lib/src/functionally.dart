abstract class Magma<A> {
  A get value;

  Magma<A> append(A a);
}

abstract class Semigroup<A> implements Magma<A> {
  @override
  Semigroup<A> append(A a);
}

abstract class Monoid<A> implements Semigroup<A> {
  A get empty;

  @override
  Monoid<A> append(A a);
}

final class MonoidList<A> implements Monoid<List<A>> {
  const MonoidList([this.value = const []]);

  @override
  final List<A> value;

  @override
  MonoidList<A> append(List<A> a) => MonoidList([...value, ...a]);

  @override
  List<A> get empty => const [];
}
