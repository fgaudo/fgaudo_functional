typedef Reader<R, A> = A Function(R);

Reader<R, B> Function(Reader<R, A>) flatMap<R, A, B>(
        Reader<R, B> Function(A) f) =>
    (ra) => (r) => f(ra(r))(r);

Reader<R, B> Function<R>(Reader<R, A>) map<A, B>(
  B Function(A) f,
) =>
    <R>(ra) => (r) => f(ra(r));
