import 'io.dart';

typedef Task<A> = Future<A> Function();

Task<A2> Function(
  Task<A1> task,
) map<A1, A2>(
  A2 Function(A1) mapper,
) =>
    (task) => () => task().then(mapper);

Task<(A1, A2)> sequenceTuple2<A1, A2>(
  Task<A1> te1,
  Task<A2> te2,
) =>
    () async {
      final result = await Future.wait([te1(), te2()]);
      return (result[0] as A1, result[1] as A2);
    };

Task<A> fromIO<A>(IO<A> io) => () async => io();

Task<B> Function(Task<A>) bracket<A, B>({
  required Task<void> Function(A) release,
  required Task<B> Function(A) use,
}) =>
    (acquire) => () async {
          final resource = await acquire();
          try {
            return use(resource)();
          } finally {
            await release(resource)();
          }
        };
