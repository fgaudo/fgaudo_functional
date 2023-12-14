import '../../../option.dart' as O;

extension MapOptionExtension<A> on O.Option<A> {
  O.Option<B> map<B>(
    B Function(A) some,
  ) =>
      O.map(some)(this);
}

extension MatchOptionExtension<A> on O.Option<A> {
  B match<B>({
    required B onNone,
    required B Function(A) onSome,
  }) =>
      O.match(
        onNone: onNone,
        onSome: onSome,
      )(this);
}
