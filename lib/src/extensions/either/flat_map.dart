import '../../../either.dart' as E;

extension FlatMapEitherExtension<L, R1> on E.Either<L, R1> {
  E.Either<L, R2> flatMap<R2>(
    E.Either<L, R2> Function(R1) f,
  ) =>
      E.flatMap(f)(this);
}
