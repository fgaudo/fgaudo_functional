import '../io.dart' as I;
import '../reader.dart' as R;

final class ReaderIO<ENV, A> {
  const ReaderIO(this._f);

  final R.Reader<ENV, I.IO<A>> _f;

  I.IO<A> call(ENV env) => _f(env);
}

// Constructors

ReaderIO<ENV, ENV> ask<ENV>() => ReaderIO(
      R.Reader(
        (env) => I.IO(() => env),
      ),
    );

ReaderIO<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    ReaderIO(
      R.Reader((env1) {
        final env2 = f(env1);
        return I.IO(() => env2);
      }),
    );

// Helpers

ReaderIO<ENV, A> fromReader<ENV, A>(R.Reader<ENV, I.IO<A>> r) => ReaderIO(r);

R.Reader<ENV, I.IO<A>> toReader<ENV, A>(ReaderIO<ENV, A> rio) =>
    R.Reader(rio.call);

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) flatMapIO<A, B>(
  I.IO<B> Function(A) f,
) =>
    <ENV>(rio) => ReaderIO(
          R.Reader(
            (env) {
              final io = rio(env);
              return I.IO(() => f(io())());
            },
          ),
        );

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) flatMap<ENV, A, B>(
  ReaderIO<ENV, B> Function(A) f,
) =>
    (rio) => ReaderIO(
          R.Reader(
            (env) {
              final io = rio(env);
              return I.IO(() => f(io())(env)());
            },
          ),
        );

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(rio) => ReaderIO(
          R.Reader(
            (env) {
              final io = rio(env);
              return I.IO(() => f(io()));
            },
          ),
        );

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) bracket<ENV, A, B>({
  required ReaderIO<ENV, void> Function(A) release,
  required ReaderIO<ENV, B> Function(A) use,
}) =>
    (acquire) => ReaderIO(
          R.Reader(
            (env) {
              final acquireF = acquire(env);
              return I.IO(() {
                final resource = acquireF();
                try {
                  return use(resource)(env)();
                } finally {
                  release(resource)(env)();
                }
              });
            },
          ),
        );

ReaderIO<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<ReaderIO<ENV, A>> arr,
) =>
    ReaderIO(
      R.Reader(
        (env) => I.IO(
          () => arr.map(
            (rio) => rio(env)(),
          ),
        ),
      ),
    );

ReaderIO<ENV2, A> Function<A>(ReaderIO<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => ReaderIO(
          R.Reader(
            (env2) => r(f(env2)),
          ),
        );
