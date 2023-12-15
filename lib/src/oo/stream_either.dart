import '../../../stream_either.dart' as SE;

final class StreamEitherBuilder<E, A> {
  const StreamEitherBuilder(this._f);

  final SE.StreamEither<E, A> _f;

  SE.StreamEither<E, A> build() => _f;

  StreamEitherBuilder<E2, A2> bimap<E2, A2>({
    required E2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      StreamEitherBuilder(
        SE.bimap(
          right: right,
          left: left,
        )(_f),
      );

  StreamEitherBuilder<E, A> doOnEither({
    required void Function(E) left,
    required void Function(A) right,
  }) =>
      StreamEitherBuilder(
        SE.doOnEither(
          left: left,
          right: right,
        )(_f),
      );

  StreamEitherBuilder<E, A> doOnLeft(
    void Function(E) procedure,
  ) =>
      StreamEitherBuilder(SE.doOnLeft(procedure)(_f));

  StreamEitherBuilder<E, A> doOnRight(
    void Function(A) procedure,
  ) =>
      StreamEitherBuilder(SE.doOnRight(procedure)(_f));

  StreamEitherBuilder<E2, A> mapLeft<E2>(
    E2 Function(E) left,
  ) =>
      StreamEitherBuilder(SE.mapLeft(left)(_f));

  StreamEitherBuilder<E, A2> mapRight<A2>(
    A2 Function(A) right,
  ) =>
      StreamEitherBuilder(SE.map(right)(_f));

  Stream<A2> match<A2>({
    required A2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      SE.match(left: left, right: right)(_f);
}

extension ToStreamEitherBuilderReaderExtension<L, R> on SE.StreamEither<L, R> {
  StreamEitherBuilder<L, R> toStreamEitherBuilder() =>
      StreamEitherBuilder(this);
}
