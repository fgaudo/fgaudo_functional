import '../either.dart' as E;

extension MatchEitherExtension<L, R> on E.Either<L, R> {
  A match<A>({
    required A Function(R) right,
    required A Function(L) left,
  }) =>
      E.match(right: right, left: left)(this);
}
