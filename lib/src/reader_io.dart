import '../io.dart' as I;
import '../reader.dart' as R;

typedef ReaderIO<ENV, A> = R.Reader<ENV, I.IO<A>>;

// Constructors

ReaderIO<ENV, void> make<ENV>() => (_) => () {};

ReaderIO<ENV, ENV> ask<ENV>() => (env) => () => env;

ReaderIO<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    (env1) {
      final env2 = f(env1);
      return () => env2;
    };

// Helpers

ReaderIO<ENV, A> fromReader<ENV, A>(R.Reader<ENV, I.IO<A>> r) => r;

R.Reader<ENV, I.IO<A>> toReader<ENV, A>(ReaderIO<ENV, A> rio) => rio.call;

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) flatMapIO<A, B>(
  I.IO<B> Function(A) f,
) =>
    <ENV>(rio) => (env) {
          final io = rio(env);
          return () => f(io())();
        };

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) flatMap<ENV, A, B>(
  ReaderIO<ENV, B> Function(A) f,
) =>
    (rio) => (env) {
          final io = rio(env);
          return () => f(io())(env)();
        };

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(rio) => (env) {
          final io = rio(env);
          return () => f(io());
        };

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) bracket<ENV, A, B>({
  required ReaderIO<ENV, void> Function(A) release,
  required ReaderIO<ENV, B> Function(A) use,
}) =>
    (acquire) => (env) {
          final acquireF = acquire(env);
          return () {
            final resource = acquireF();
            try {
              return use(resource)(env)();
            } finally {
              release(resource)(env)();
            }
          };
        };

ReaderIO<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<ReaderIO<ENV, A>> arr,
) =>
    (env) => () => arr.map(
          (rio) => rio(env)(),
        );

ReaderIO<ENV2, A> Function<A>(ReaderIO<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));

ReaderIO<ENV, A> Function<A>(ReaderIO<ENV, A>) apFirst<ENV, B>(
  ReaderIO<ENV, B> rio1,
) =>
    <A>(rio2) => (env) {
          final io = rio1(env);
          return flatMap<ENV, A, A>(
            (a) => (_) => () {
                  io();
                  return a;
                },
          )(rio2)(env);
        };

ReaderIO<ENV, B> Function<A>(ReaderIO<ENV, A>) apSecond<ENV, B>(
  ReaderIO<ENV, B> rio1,
) =>
    <A>(rio2) => flatMap(
          (_) => rio1,
        )(rio2);
