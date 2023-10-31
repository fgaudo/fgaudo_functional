import '../stream_either.dart' as SE;

extension MapRightStreamEitherExtension<L, R1> on SE.StreamEither<L, R1> {
  SE.StreamEither<L, R2> mapRight<R2>(
    R2 Function(R1) right,
  ) =>
      SE.map(right)(this);
}
