import '../stream_either.dart';

extension BimapStreamEitherExtension<L1, R1> on StreamEither<L1, R1> {
  StreamEither<L2, R2> bimap<L2, R2>({
    required L2 Function(L1) left,
    required R2 Function(R1) right,
  }) =>
      BimapEitherStreamTransformer(
        right: right,
        left: left,
      ).bind(this);
}
