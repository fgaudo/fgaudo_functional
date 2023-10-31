import 'dart:async';

import 'package:fgaudo_functional/common.dart';

import '../either/either.dart';
import '../task_either/task_either.dart';

typedef StreamEither<L, R> = Stream<Either<L, R>>;

StreamEither<L, R> fromTaskEither<L, R>(
  TaskEither<L, R> t,
) =>
    Stream.fromFuture(t());

final class BimapStreamEitherTransformer<L1, L2, R1, R2>
    extends StreamTransformerBase<Either<L1, R1>, Either<L2, R2>> {
  const BimapStreamEitherTransformer({
    required this.right,
    required this.left,
  });
  final R2 Function(R1) right;
  final L2 Function(L1) left;

  @override
  Stream<Either<L2, R2>> bind(
    Stream<Either<L1, R1>> stream,
  ) =>
      FoldStreamEitherTransformer<L1, R1, Either<L2, R2>>(
        right: (value) => Right(this.right(value)),
        left: (value) => Left(this.left(value)),
      ).bind(stream);
}

final class MapLeftStreamEitherTransformer<L1, L2, R>
    extends StreamTransformerBase<Either<L1, R>, Either<L2, R>> {
  const MapLeftStreamEitherTransformer(this.left);
  final L2 Function(L1) left;

  @override
  Stream<Either<L2, R>> bind(
    Stream<Either<L1, R>> stream,
  ) =>
      FoldStreamEitherTransformer<L1, R, Either<L2, R>>(
        left: (value) => Left(this.left(value)),
        right: (value) => Right(identity1(value)),
      ).bind(stream);
}

final class MapRightStreamEitherTransformer<L, R1, R2>
    extends StreamTransformerBase<Either<L, R1>, Either<L, R2>> {
  const MapRightStreamEitherTransformer(this.right);
  final R2 Function(R1) right;

  @override
  Stream<Either<L, R2>> bind(
    Stream<Either<L, R1>> stream,
  ) =>
      FoldStreamEitherTransformer<L, R1, Either<L, R2>>(
        left: (value) => Left(identity1(value)),
        right: (value) => Right(this.right(value)),
      ).bind(stream);
}

final class FoldStreamEitherTransformer<L, R, A>
    extends StreamTransformerBase<Either<L, R>, A> {
  const FoldStreamEitherTransformer({
    required this.right,
    required this.left,
  });

  final A Function(L) left;
  final A Function(R) right;

  @override
  Stream<A> bind(
    Stream<Either<L, R>> stream,
  ) =>
      stream.map(
        (event) => switch (event) {
          Right(value: final value) => this.right(value),
          Left(value: final value) => this.left(value)
        },
      );
}
