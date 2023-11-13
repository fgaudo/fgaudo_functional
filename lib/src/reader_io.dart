import '../io.dart' as I;
import '../io.dart';
import '../reader.dart';

typedef ReaderIO<ENV, A> = Reader<ENV, IO<A>>;

// Constructors

ReaderIO<ENV, ENV> ask<ENV>() => (env) => () => env;

ReaderIO<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    (env1) {
      final env2 = f(env1);
      return () => env2;
    };

// Helpers

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

ReaderIO<R, Iterable<A>> sequenceArray<R, A>(Iterable<ReaderIO<R, A>> arr) =>
    (env) => () => arr.map(
          (rio) => rio(env)(),
        );
