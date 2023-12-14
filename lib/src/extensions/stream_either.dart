import '../../../stream_either.dart' as SE;

extension BimapStreamEitherExtension<L1, R1> on SE.StreamEither<L1, R1> {
  SE.StreamEither<L2, R2> bimap<L2, R2>({
    required L2 Function(L1) left,
    required R2 Function(R1) right,
  }) =>
      SE.bimap(right: right, left: left)(this);
}

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

extension DoOnLeftStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  SE.StreamEither<L, R> doOnLeft(
    void Function(L) procedure,
  ) =>
      SE.doOnLeft(procedure)(this);
}

extension DoOnRightStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  SE.StreamEither<L, R> doOnRight(
    void Function(R) procedure,
  ) =>
      SE.doOnRight(procedure)(this);
}

extension MapLeftStreamEitherExtension<L1, R> on SE.StreamEither<L1, R> {
  SE.StreamEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      SE.mapLeft(left)(this);
}

extension MapRightStreamEitherExtension<L, R1> on SE.StreamEither<L, R1> {
  SE.StreamEither<L, R2> mapRight<R2>(
    R2 Function(R1) right,
  ) =>
      SE.map(right)(this);
}

extension MatchStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  Stream<A> match<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      SE.match(left: left, right: right)(this);
}
