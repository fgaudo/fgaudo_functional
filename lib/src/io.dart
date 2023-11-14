typedef IO<A> = A Function();

IO<B> Function(IO<A>) bracket<A, B>({
  required IO<void> Function(A) release,
  required IO<B> Function(A) use,
}) =>
    (acquire) => () {
          final resource = acquire();
          try {
            return use(resource)();
          } finally {
            release(resource)();
          }
        };

IO<B> Function(IO<A>) flatMap<A, B>(
  IO<B> Function(A) f,
) =>
    (io) => () => f(io())();

IO<B> Function(IO<A>) map<A, B>(
  B Function(A) f,
) =>
    (io) => () => f(io());
