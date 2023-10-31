import '../either.dart' as E;

extension MapLeftEitherExtension<L1, R> on E.Either<L1, R> {
  E.Either<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      E.mapLeft(left)(this);
}
