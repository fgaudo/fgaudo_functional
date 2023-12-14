import '../reader.dart' as R;
import '../reader_io.dart' as RIO;
import '../task.dart' as T;

typedef ReaderTask<ENV, A> = R.Reader<ENV, T.Task<A>>;

// Constructors

ReaderTask<ENV, void> make<ENV>() => (_) => () async {};
ReaderTask<ENV, ENV> ask<ENV>() => (env) => () async => env;

ReaderTask<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    (env1) {
      final env2 = f(env1);
      return () async => env2;
    };

// Helpers

ReaderTask<ENV, A> fromReader<ENV, A>(R.Reader<ENV, T.Task<A>> r) => r;

ReaderTask<ENV, A> fromReaderIO<ENV, A>(RIO.ReaderIO<ENV, A> rio) =>
    (env) => () async => rio(env)();

R.Reader<ENV, T.Task<A>> toReader<ENV, A>(ReaderTask<ENV, A> rt) => rt.call;

ReaderTask<ENV, B> Function<ENV>(ReaderTask<ENV, A>) flatMapTask<A, B>(
  T.Task<B> Function(A) f,
) =>
    <ENV>(rt) => (env) {
          final task = rt(env);
          return () async => f(await task())();
        };

ReaderTask<ENV, B> Function(ReaderTask<ENV, A>) flatMap<ENV, A, B>(
  ReaderTask<ENV, B> Function(A) f,
) =>
    (rt) => (env) {
          final task = rt(env);
          return () async => f(await task())(env)();
        };

ReaderTask<ENV, B> Function<ENV>(ReaderTask<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(rt) => (env) {
          final task = rt(env);
          return () async => f(await task());
        };

ReaderTask<ENV, B> Function(ReaderTask<ENV, A>) bracket<ENV, A, B>({
  required ReaderTask<ENV, void> Function(A) release,
  required ReaderTask<ENV, B> Function(A) use,
}) =>
    (acquire) => (env) {
          final acquireF = acquire(env);
          return () async {
            final resource = await acquireF();
            try {
              return use(resource)(env)();
            } finally {
              await release(resource)(env)();
            }
          };
        };

ReaderTask<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<ReaderTask<ENV, A>> arr,
) =>
    (env) => () => Future.wait(
          arr.map(
            (rt) => rt(env)(),
          ),
        );

ReaderTask<ENV2, A> Function<A>(ReaderTask<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));
