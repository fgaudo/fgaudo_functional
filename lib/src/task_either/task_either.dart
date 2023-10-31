import '../either/either.dart' as E;
import '../task/task.dart';

typedef TaskEither<L, R> = Future<E.Either<L, R>> Function();

Task<A> Function<A>({
  required A Function(L) left,
  required A Function(R) right,
}) fold<L, R>(E.Either<L, R> either) => <A>({
      required left,
      required right,
    }) =>
        () async => E.fold(either)(left: left, right: right);

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
