typedef Reader<R, A> = A Function(R);

Reader<R, B> Function(Reader<R, A>) flatMap<R, A, B>(
  Reader<R, B> Function(A) f,
) =>
    (ra) => (r) => f(ra(r))(r);

Reader<R, B> Function<R>(Reader<R, A>) map<A, B>(
  B Function(A) f,
) =>
    <R>(ra) => (r) => f(ra(r));

Reader<ENV, A> asks<ENV, A>(
  A Function(ENV) f,
) =>
    f;

Reader<ENV2, A> Function<A>(Reader<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));

Reader<R, void> Do<R>() => (_) {};
