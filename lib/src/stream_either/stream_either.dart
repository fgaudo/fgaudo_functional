import 'dart:async';

import '../either/either.dart';
import '../task_either/task_either.dart';

typedef StreamEither<L, R> = Stream<Either<L, R>>;

StreamEither<L, R> fromTaskEither<L, R>(
  TaskEither<L, R> t,
) =>
    Stream.fromFuture(t());

final class BimapEitherStreamTransformer<L1, L2, R1, R2>
    extends StreamTransformerBase<Either<L1, R1>, Either<L2, R2>> {
  const BimapEitherStreamTransformer({
    required this.right,
    required this.left,
  });
  final R2 Function(R1) right;
  final L2 Function(L1) left;

  @override
  Stream<Either<L2, R2>> bind(
    Stream<Either<L1, R1>> stream,
  ) =>
      FoldEitherStreamTransformer<L1, R1, Either<L2, R2>>(
        right: (value) => Right(this.right(value)),
        left: (value) => Left(this.left(value)),
      ).bind(stream);
}

final class FoldEitherStreamTransformer<L, R, A>
    extends StreamTransformerBase<Either<L, R>, A> {
  const FoldEitherStreamTransformer({
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
