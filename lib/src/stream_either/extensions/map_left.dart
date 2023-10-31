import '../stream_either.dart' as SE;

extension MapLeftStreamEitherExtension<L1, R> on SE.StreamEither<L1, R> {
  SE.StreamEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      SE.mapLeft(this)(left);
}
