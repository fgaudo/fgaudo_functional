import '../../../option.dart' as O;

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
