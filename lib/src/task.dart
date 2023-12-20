import 'io.dart';

typedef Task<A> = Future<A> Function();

Task<A2> Function(
  Task<A1> task,
) map<A1, A2>(
  A2 Function(A1) mapper,
) =>
    (task) => () => task().then(mapper);

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

Task<B> Function<B>(Task<B Function(A)>) ap<A>(
  Task<A> t,
) =>
    <B>(ft) => () => Future.wait([ft(), t()])
        .then((value) => (value[0]! as B Function(A))(value[1] as A));

Task<B> Function<B>(Task<B Function(A)>) apSeq<A>(
  Task<A> t,
) =>
    <B>(ft) => () => ft().then((f) => map(f)(t)());
