import '../either.dart';
import 'either.dart' as E;
import 'task.dart';

typedef TaskEither<L, R> = Future<E.Either<L, R>> Function();

Task<A> Function(
  TaskEither<L, R> taskEither,
) match<L, R, A>({
  required A Function(L) left,
  required A Function(R) right,
}) =>
    (taskEither) => () => taskEither().then(
          E.match(
            left: left,
            right: right,
          ),
        );

TaskEither<L, R2> Function<L>(
  TaskEither<L, R1> taskEither,
) map<R1, R2>(
  R2 Function(R1) right,
) =>
    <L>(taskEither) => () => taskEither().then(E.map(right));

TaskEither<L2, R> Function<R>(
  TaskEither<L1, R> taskEither,
) mapLeft<L1, L2>(
  L2 Function(L1) left,
) =>
    <L>(taskEither) => () => taskEither().then(E.mapLeft(left));

TaskEither<L2, R2> Function(
  TaskEither<L1, R1> taskEither,
) bimap<L1, L2, R1, R2>({
  required L2 Function(L1) left,
  required R2 Function(R1) right,
}) =>
    (taskEither) => () => taskEither().then(
          E.bimap(
            left: left,
            right: right,
          ),
        );

TaskEither<L, (R1, R2)> sequenceTuple2<L, R1, R2>(
  TaskEither<L, R1> te1,
  TaskEither<L, R2> te2,
) =>
    () async {
      try {
        final result = await Future.wait(
          [
            () async {
              final res1 = await te1();
              switch (res1) {
                case E.Right(value: final value):
                  return value;
                case E.Left(value: final value):
                  throw _FailFastException(value);
              }
            }(),
            () async {
              final res2 = await te2();
              switch (res2) {
                case E.Right(value: final value):
                  return value;
                case E.Left(value: final value):
                  throw _FailFastException(value);
              }
            }(),
          ],
          eagerError: true,
        );

        return E.Right(
          (
            result[0] as R1,
            result[1] as R2,
          ),
        );
      } on _FailFastException<L> catch (e) {
        return E.Left(e.value);
      }
    };

final class _FailFastException<T> implements Exception {
  const _FailFastException(this.value);

  final T value;
}

final class _EvalException<A> implements Exception {
  const _EvalException(this.value);
  final A value;
}

TaskEither<L, R> doTaskEither<L, R>(
  Future<R> Function(
    Future<A> Function<A>(TaskEither<L, A>),
  ) f,
) =>
    () async {
      try {
        return Right(
          await f(
            <A>(either) async => switch (await either()) {
              Right(value: final value) => value,
              Left(value: final value) => throw _EvalException(value)
            },
          ),
        );
      } on _EvalException<L> catch (e) {
        return Left(e.value);
      }
    };
