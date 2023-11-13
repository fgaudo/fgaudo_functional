import '../io.dart' as I;
import '../io.dart';
import '../reader.dart';

final class ReaderIO<ENV, A> {
  const ReaderIO(this._f);

  final IO<A> Function(ENV) _f;

  IO<A> call(ENV env) => _f(env);
}

// Constructors

ReaderIO<ENV, ENV> ask<ENV>() => ReaderIO((env) => () => env);

ReaderIO<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    ReaderIO((env1) {
      final env2 = f(env1);
      return () => env2;
    });

// Helpers

Reader<ENV, IO<A>> Function<ENV, A>(ReaderIO<ENV, A>) toReader() =>
    <ENV, A>(rio) => Reader(rio.call);

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) flatMapIO<A, B>(
  I.IO<B> Function(A) f,
) =>
    <ENV>(rio) => ReaderIO(
          (env) {
            final io = rio(env);
            return () => f(io())();
          },
        );

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) flatMap<ENV, A, B>(
  ReaderIO<ENV, B> Function(A) f,
) =>
    (rio) => ReaderIO(
          (env) {
            final io = rio(env);
            return () => f(io())(env)();
          },
        );

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(rio) => ReaderIO(
          (env) {
            final io = rio(env);
            return () => f(io());
          },
        );

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) bracket<ENV, A, B>({
  required ReaderIO<ENV, void> Function(A) release,
  required ReaderIO<ENV, B> Function(A) use,
}) =>
    (acquire) => ReaderIO(
          (env) {
            final acquireF = acquire(env);
            return () {
              final resource = acquireF();
              try {
                return use(resource)(env)();
              } finally {
                release(resource)(env)();
              }
            };
          },
        );

ReaderIO<R, Iterable<A>> sequenceArray<R, A>(Iterable<ReaderIO<R, A>> arr) =>
    ReaderIO(
      (env) => () => arr.map(
            (rio) => rio(env)(),
          ),
    );
