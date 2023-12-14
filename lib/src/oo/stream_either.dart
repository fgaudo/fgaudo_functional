import '../../../stream_either.dart' as SE;

final class StreamEither<E, A> {
  const StreamEither(this._f);

  final SE.StreamEither<E, A> _f;

  StreamEither<E2, A2> bimap<E2, A2>({
    required E2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      StreamEither(SE.bimap(
        right: right,
        left: left,
      )(_f));

  StreamEither<E, A> doOnEither({
    required void Function(E) left,
    required void Function(A) right,
  }) =>
      StreamEither(
        SE.doOnEither(
          left: left,
          right: right,
        )(_f),
      );

  StreamEither<E, A> doOnLeft(
    void Function(E) procedure,
  ) =>
      StreamEither(SE.doOnLeft(procedure)(_f));

  StreamEither<E, A> doOnRight(
    void Function(A) procedure,
  ) =>
      StreamEither(SE.doOnRight(procedure)(_f));

  StreamEither<E2, A> mapLeft<E2>(
    E2 Function(E) left,
  ) =>
      StreamEither(SE.mapLeft(left)(_f));

  StreamEither<E, A2> mapRight<A2>(
    A2 Function(A) right,
  ) =>
      StreamEither(SE.map(right)(_f));

  Stream<A2> match<A2>({
    required A2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      SE.match(left: left, right: right)(_f);
}
