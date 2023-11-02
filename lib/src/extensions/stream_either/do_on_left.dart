import '../../../stream_either.dart' as SE;

extension DoOnLeftStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  SE.StreamEither<L, R> doOnLeft(
    void Function(L) procedure,
  ) =>
      SE.doOnLeft(procedure)(this);
}
