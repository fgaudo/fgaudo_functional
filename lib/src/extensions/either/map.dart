import '../../either.dart' as E;

extension MapEitherExtension<L, R1> on E.Either<L, R1> {
  E.Either<L, R2> map<R2>(
    R2 Function(R1) right,
  ) =>
      E.map(right)(this);
}
