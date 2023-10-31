import '../common.dart';

sealed class Either<L, R> {}

final class Left<L, R> implements Either<L, R> {
  const Left(this.value);
  final L value;
}

final class Right<L, R> implements Either<L, R> {
  const Right(this.value);
  final R value;
}

A Function(Either<L, R> either) fold<A, L, R>({
  required A Function(L) left,
  required A Function(R) right,
}) =>
    (either) => switch (either) {
          Left(value: final value) => left(value),
          Right(value: final value) => right(value)
        };

Either<L2, R2> Function(
  Either<L1, R1> either,
) bimap<L1, L2, R1, R2>({
  required L2 Function(L1) left,
  required R2 Function(R1) right,
}) =>
    fold(
      left: (value) => Left(left(value)),
      right: (value) => Right(right(value)),
    );

Either<L, R2> Function<L>(
  Either<L, R1> either,
) map<R1, R2>(
  R2 Function(R1) right,
) =>
    <L>(either) => bimap(
          left: identity1<L>,
          right: right,
        )(either);

Either<L2, R> Function<R>(
  Either<L1, R> either,
) mapLeft<L1, L2>(
  L2 Function(L1) left,
) =>
    <R>(either) => bimap(
          left: left,
          right: identity1<R>,
        )(either);
