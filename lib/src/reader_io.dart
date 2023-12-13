import '../extensions/io/flat_map.dart';
import '../extensions/reader_io.dart';
import '../io.dart' as I;
import '../reader.dart' as R;

final class ReaderIO<ENV, A> {
  const ReaderIO(this._f);

  final R.Reader<ENV, I.IO<A>> _f;

  I.IO<A> call(ENV env) => _f(env);
}

// Constructors

ReaderIO<ENV, void> make<ENV>() => ReaderIO(
      (_) => () {},
    );

ReaderIO<ENV, ENV> ask<ENV>() => ReaderIO(
      (env) => () => env,
    );

ReaderIO<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    ReaderIO(
      (env1) {
        final env2 = f(env1);
        return () => env2;
      },
    );

// Helpers

ReaderIO<ENV, A> fromReader<ENV, A>(R.Reader<ENV, I.IO<A>> r) => ReaderIO(r);

R.Reader<ENV, I.IO<A>> toReader<ENV, A>(ReaderIO<ENV, A> rio) => rio.call;

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

ReaderIO<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<ReaderIO<ENV, A>> arr,
) =>
    ReaderIO(
      (env) => () => arr.map(
            (rio) => rio(env)(),
          ),
    );

ReaderIO<ENV2, A> Function<A>(ReaderIO<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => ReaderIO(
          (env2) => r(f(env2)),
        );

ReaderIO<ENV, A> Function<A>(ReaderIO<ENV, A>) apFirst<ENV, B>(
  ReaderIO<ENV, B> rio1,
) =>
    <A>(rio2) => ReaderIO(
          (env) => rio2(env).flatMap(
            (a) => () {
              rio1(env)();
              return a;
            },
          ),
        );

ReaderIO<ENV, B> Function<A>(ReaderIO<ENV, A>) apSecond<ENV, B>(
  ReaderIO<ENV, B> rio1,
) =>
    <A>(rio2) => ReaderIO(
          (env) => rio2(env).flatMap(
            (_) => rio1(env),
          ),
        );
