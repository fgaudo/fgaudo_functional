import '../common.dart';

typedef Reader<ENV, A> = A Function(ENV);

// Constructors

Reader<ENV, ENV> ask<ENV>() => identity;

Reader<ENV1, ENV2> asks<ENV1, ENV2>(
  ENV2 Function(ENV1) f,
) =>
    f;

// Helpers

Reader<R, B> Function(Reader<R, A>) flatMap<R, A, B>(
  Reader<R, B> Function(A) f,
) =>
    (ra) => (r) => f(ra(r))(r);

Reader<R, B> Function<R>(Reader<R, A>) map<A, B>(
  B Function(A) f,
) =>
    <R>(ra) => (r) => f(ra(r));

Reader<ENV2, A> Function<A>(Reader<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));

Reader<R, Iterable<A>> sequenceArray<R, A>(Iterable<Reader<R, A>> arr) =>
    (env) => arr.map((r) => r(env));
