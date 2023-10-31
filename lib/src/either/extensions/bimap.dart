import '../either.dart' as E;

extension BimapEitherExtension<L1, R1> on E.Either<L1, R1> {
  E.Either<L2, R2> bimap<L2, R2>({
    required R2 Function(R1) right,
    required L2 Function(L1) left,
  }) =>
      E.bimap(this)(right: right, left: left);
}
