sealed class Either<L, R> {}

final class Left<L, R> implements Either<L, R> {
  const Left(this.value);
  final L value;
}

final class Right<L, R> implements Either<L, R> {
  const Right(this.value);
  final R value;
}

A Function(
  Either<L, R> either,
) match<A, L, R>({
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
    match(
      left: (value) => Left(left(value)),
      right: (value) => Right(right(value)),
    );

Either<L, R2> Function<L>(
  Either<L, R1> either,
) map<R1, R2>(
  R2 Function(R1) right,
) =>
    <L>(either) => switch (either) {
          Left(value: final value) => Left(value),
          Right(value: final value) => Right(right(value))
        };

Either<L2, R> Function<R>(
  Either<L1, R> either,
) mapLeft<L1, L2>(
  L2 Function(L1) left,
) =>
    <R>(either) => switch (either) {
          Left(value: final value) => Left(left(value)),
          Right(value: final value) => Right(value)
        };
