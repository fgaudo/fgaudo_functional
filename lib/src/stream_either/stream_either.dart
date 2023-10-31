import 'dart:async';

import 'package:fgaudo_functional/common.dart';

import '../either/either.dart';
import '../task_either/task_either.dart';

typedef StreamEither<L, R> = Stream<Either<L, R>>;

StreamEither<L, R> fromTaskEither<L, R>(
  TaskEither<L, R> t,
) =>
    Stream.fromFuture(t());

StreamEither<L2, R> Function<R>(
  StreamEither<L1, R> either$,
) mapLeft<L1, L2>(
  L2 Function(L1) left,
) =>
    <R>(either$) => bimap<L1, L2, R, R>(
          left: left,
          right: identity1,
        )(either$);

StreamEither<L, R2> Function<L>(
  StreamEither<L, R1> either$,
) mapRight<R1, R2>(
  R2 Function(R1) right,
) =>
    <L>(either$) => bimap<L, L, R1, R2>(
          left: identity1,
          right: right,
        )(either$);

Stream<A> Function(
  StreamEither<L, R> either$,
) fold<A, L, R>({
  required A Function(L) left,
  required A Function(R) right,
}) =>
    (either$) => either$.map(
          (event) => switch (event) {
            Right(value: final value) => right(value),
            Left(value: final value) => left(value)
          },
        );

StreamEither<L2, R2> Function(
  StreamEither<L1, R1> either$,
) bimap<L1, L2, R1, R2>({
  required L2 Function(L1) left,
  required R2 Function(R1) right,
}) =>
    fold(
      left: (value) => Left(left(value)),
      right: (value) => Right(right(value)),
    );

final class BimapStreamEitherTransformer<L1, L2, R1, R2>
    extends StreamTransformerBase<Either<L1, R1>, Either<L2, R2>> {
  const BimapStreamEitherTransformer({
    required this.left,
    required this.right,
  });
  final L2 Function(L1) left;
  final R2 Function(R1) right;

  @override
  StreamEither<L2, R2> bind(
    StreamEither<L1, R1> either$,
  ) =>
      bimap(left: left, right: right)(either$);
}

final class MapLeftStreamEitherTransformer<L1, L2, R>
    extends StreamTransformerBase<Either<L1, R>, Either<L2, R>> {
  const MapLeftStreamEitherTransformer(this.left);
  final L2 Function(L1) left;

  @override
  StreamEither<L2, R> bind(
    StreamEither<L1, R> either$,
  ) =>
      mapLeft(left)(either$);
}

final class MapRightStreamEitherTransformer<L, R1, R2>
    extends StreamTransformerBase<Either<L, R1>, Either<L, R2>> {
  const MapRightStreamEitherTransformer(this.right);
  final R2 Function(R1) right;

  @override
  StreamEither<L, R2> bind(
    StreamEither<L, R1> either$,
  ) =>
      mapRight(right)(either$);
}

final class FoldStreamEitherTransformer<L, R, A>
    extends StreamTransformerBase<Either<L, R>, A> {
  const FoldStreamEitherTransformer({
    required this.left,
    required this.right,
  });

  final A Function(L) left;
  final A Function(R) right;

  @override
  Stream<A> bind(
    StreamEither<L, R> either$,
  ) =>
      fold(left: left, right: right)(either$);
}
