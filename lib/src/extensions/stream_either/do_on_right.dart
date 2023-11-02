import '../../../stream_either.dart' as SE;

extension DoOnRightStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  SE.StreamEither<L, R> doOnRight(
    void Function(R) procedure,
  ) =>
      SE.doOnRight(procedure)(this);
}
