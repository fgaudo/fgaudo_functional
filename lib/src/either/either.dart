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

A Function<A>({
  required A Function(L) left,
  required A Function(R) right,
}) fold<L, R>(Either<L, R> either) => <A>({
      required left,
      required right,
    }) =>
        switch (either) {
          Left(value: final value) => left(value),
          Right(value: final value) => right(value)
        };

Either<L2, R2> Function<L2, R2>({
  required L2 Function(L1) left,
  required R2 Function(R1) right,
}) bimap<L1, R1>(Either<L1, R1> either) => <L2, R2>({
      required left,
      required right,
    }) =>
        fold(either)(
          left: (value) => Left(left(value)),
          right: (value) => Right(right(value)),
        );

Either<L, R2> Function<R2>(
  R2 Function(R1) right,
) map<L, R1>(Either<L, R1> either) =>
    <R2>(right) => bimap(either)(left: identity1, right: right);

Either<L2, R> Function<L2>(
  L2 Function(L1) left,
) mapLeft<L1, R>(Either<L1, R> either) =>
    <L2>(left) => bimap(either)(left: left, right: identity1);
