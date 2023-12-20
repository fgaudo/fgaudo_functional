import '../common.dart';

typedef Reader<ENV, A> = A Function(ENV);

// Constructors

Reader<ENV, A> of<ENV, A>(A a) => (_) => a;

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

Reader<R, B> Function(Reader<R, A>) map_<R, A, B>(
  B Function(A) f,
) =>
    map(f);

Reader<ENV2, A> Function<A>(Reader<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));

Reader<ENV2, A> Function(Reader<ENV1, A>) local_<A, ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    local(f);

Reader<R, Iterable<A>> sequenceArray<R, A>(Iterable<Reader<R, A>> arr) =>
    (env) => arr.map((r) => r(env));

Reader<ENV, A> Function<A>(Reader<ENV, A>) apFirst<ENV, B>(
  Reader<ENV, B> r1,
) =>
    <A>(r2) => flatMap<ENV, A, A>((a) => map<B, A>((_) => a)(r1))(r2);

Reader<ENV, B> Function<A>(Reader<ENV, A>) apSecond<ENV, B>(
  Reader<ENV, B> r1,
) =>
    <A>(r2) => flatMap(
          (_) => r1,
        )(r2);
