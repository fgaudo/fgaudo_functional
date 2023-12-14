import '../../../option.dart' as O;

typedef Option<A> = O.Option<A>;

extension MapOptionExtension<A> on Option<A> {
  Option<B> map<B>(
    B Function(A) some,
  ) =>
      O.map(some)(this);
}

extension MatchOptionExtension<A> on Option<A> {
  B match<B>({
    required B onNone,
    required B Function(A) onSome,
  }) =>
      O.match(
        onNone: onNone,
        onSome: onSome,
      )(this);
}
