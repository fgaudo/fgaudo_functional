import 'dart:async';

import 'package:fgaudo_functional/common.dart';

import '../either/either.dart';
import '../task_either/task_either.dart';

typedef StreamEither<L, R> = Stream<Either<L, R>>;

StreamEither<L, R> fromTaskEither<L, R>(
  TaskEither<L, R> t,
) =>
    Stream.fromFuture(t());

StreamEither<L2, R> Function<L2>(
  L2 Function(L1) left,
) mapLeft<L1, R>(
  StreamEither<L1, R> stream$,
) =>
    <L2>(left) => bimap(stream$)(
          left: left,
          right: identity1,
        );

StreamEither<L, R2> Function<R2>(
  R2 Function(R1) right,
) mapRight<L, R1>(
  StreamEither<L, R1> stream$,
) =>
    <R2>(right) => bimap(stream$)(
          left: identity1,
          right: right,
        );

Stream<A> Function<A>({
  required A Function(L) left,
  required A Function(R) right,
}) fold<L, R>(
  StreamEither<L, R> stream$,
) =>
    <A>({
      required left,
      required right,
    }) =>
        stream$.map(
          (event) => switch (event) {
            Right(value: final value) => right(value),
            Left(value: final value) => left(value)
          },
        );

StreamEither<L2, R2> Function<L2, R2>({
  required L2 Function(L1) left,
  required R2 Function(R1) right,
}) bimap<L1, R1>(
  StreamEither<L1, R1> stream$,
) =>
    <L2, R2>({
      required left,
      required right,
    }) =>
        fold(stream$)(
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
  Stream<Either<L2, R2>> bind(
    Stream<Either<L1, R1>> stream,
  ) =>
      bimap(stream)(left: left, right: right);
}

final class MapLeftStreamEitherTransformer<L1, L2, R>
    extends StreamTransformerBase<Either<L1, R>, Either<L2, R>> {
  const MapLeftStreamEitherTransformer(this.left);
  final L2 Function(L1) left;

  @override
  Stream<Either<L2, R>> bind(
    Stream<Either<L1, R>> stream,
  ) =>
      mapLeft(stream)(left);
}

final class MapRightStreamEitherTransformer<L, R1, R2>
    extends StreamTransformerBase<Either<L, R1>, Either<L, R2>> {
  const MapRightStreamEitherTransformer(this.right);
  final R2 Function(R1) right;

  @override
  Stream<Either<L, R2>> bind(
    Stream<Either<L, R1>> stream,
  ) =>
      mapRight(stream)(right);
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
    Stream<Either<L, R>> stream,
  ) =>
      fold(stream)(left: left, right: right);
}
