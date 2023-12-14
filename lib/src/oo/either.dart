import '../../../either.dart' as E;

extension MapLeftEitherExtension<L1, R> on E.Either<L1, R> {
  E.Either<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      E.mapLeft(left)(this);
}

extension BimapEitherExtension<L1, R1> on E.Either<L1, R1> {
  E.Either<L2, R2> bimap<L2, R2>({
    required R2 Function(R1) right,
    required L2 Function(L1) left,
  }) =>
      E.bimap(right: right, left: left)(this);
}

extension FlatMapEitherExtension<L, R1> on E.Either<L, R1> {
  E.Either<L, R2> flatMap<R2>(
    E.Either<L, R2> Function(R1) f,
  ) =>
      E.flatMap(f)(this);
}

extension MapEitherExtension<L, R1> on E.Either<L, R1> {
  E.Either<L, R2> map<R2>(
    R2 Function(R1) right,
  ) =>
      E.map(right)(this);
}

extension MatchEitherExtension<L, R> on E.Either<L, R> {
  A match<A>({
    required A Function(R) right,
    required A Function(L) left,
  }) =>
      E.match(right: right, left: left)(this);
}
