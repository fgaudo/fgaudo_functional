typedef Task<A> = Future<A> Function();

Task<(A1, A2)> sequenceTuple2<A1, A2>(
  Task<A1> te1,
  Task<A2> te2,
) =>
    () async {
      final result = await Future.wait([te1(), te2()]);
      return (result[0] as A1, result[1] as A2);
    };
