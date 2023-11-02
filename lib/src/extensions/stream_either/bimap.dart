import '../../../stream_either.dart' as SE;

extension BimapStreamEitherExtension<L1, R1> on SE.StreamEither<L1, R1> {
  SE.StreamEither<L2, R2> bimap<L2, R2>({
    required L2 Function(L1) left,
    required R2 Function(R1) right,
  }) =>
      SE.bimap(right: right, left: left)(this);
}
