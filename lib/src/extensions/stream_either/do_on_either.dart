import '../../../stream_either.dart' as SE;

extension DoOnEitherStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  SE.StreamEither<L, R> doOnEither({
    required void Function(L) left,
    required void Function(R) right,
  }) =>
      SE.doOnEither(
        left: left,
        right: right,
      )(this);
}
