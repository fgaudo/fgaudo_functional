import '../common.dart';

final class Reader<ENV, A> {
  const Reader(this._f);

  final A Function(ENV) _f;
  A call(ENV env) => _f(env);
}

// Constructors

Reader<ENV, ENV> ask<ENV>() => Reader(identity);

Reader<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    Reader(f);

// Helpers

Reader<R, B> Function(Reader<R, A>) flatMap<R, A, B>(
  Reader<R, B> Function(A) f,
) =>
    (ra) => Reader(
          (r) => f(ra(r))(r),
        );

Reader<R, B> Function<R>(Reader<R, A>) map<A, B>(
  B Function(A) f,
) =>
    <R>(ra) => Reader(
          (r) => f(ra(r)),
        );

Reader<ENV2, A> Function<A>(Reader<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => Reader(
          (env2) => r(f(env2)),
        );

Reader<R, Iterable<A>> sequenceArray<R, A>(Iterable<Reader<R, A>> arr) =>
    Reader(
      (env) => arr.map((r) => r(env)),
    );
