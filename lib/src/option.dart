sealed class Option<A> {}

final class None<A> implements Option<A> {
  const None();
}

final class Some<A> implements Option<A> {
  const Some(this.value);

  final A value;
}

Option<A> fromNullable<A>(A? a) => a == null ? None() : Some(a);

B Function(Option<A>) match<A, B>({
  required B onNone,
  required B Function(A) onSome,
}) =>
    (option) => switch (option) {
          Some(value: final value) => onSome(value),
          None() => onNone
        };

Option<B> Function(Option<A>) map<A, B>(
  B Function(A) mapper,
) =>
    (option) => match(
          onNone: None<B>(),
          onSome: (A value) => Some(
            mapper(value),
          ),
        )(option);
