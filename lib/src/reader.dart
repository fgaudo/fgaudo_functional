import '../common.dart';

final class Reader<ENV, A> {
  const Reader(this._f);

  final A Function(ENV) _f;
  A call(ENV env) => _f(env);

  A Function(ENV) get asFunction => _f;
}

Reader<R, B> Function(Reader<R, A>) flatMap<R, A, B>(
  Reader<R, B> Function(A) f,
) =>
    (ra) => Reader((r) => f(ra(r))(r));

Reader<R, B> Function<R>(Reader<R, A>) map<A, B>(
  B Function(A) f,
) =>
    <R>(ra) => Reader((r) => f(ra(r)));

Reader<ENV, ENV> ask<ENV>() => Reader(identity);

Reader<ENV, A> asks<ENV, A>(
  A Function(ENV) f,
) =>
    Reader(f);

Reader<ENV2, A> Function<A>(Reader<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => Reader((env2) => r(f(env2)));

Reader<R, void> Do<R>() => Reader((_) {});

Reader<R, Iterable<A>> sequenceArray<R, A>(Iterable<Reader<R, A>> arr) =>
    Reader((env) => arr.map((r) => r(env)));
