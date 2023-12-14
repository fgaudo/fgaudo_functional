import '../../../task.dart' as T;

final class Task<A> {
  const Task(this._f);

  final T.Task<A> _f;

  Task<B> bracket<B>({
    required T.Task<B> Function(A) use,
    required T.Task<void> Function(A) release,
  }) =>
      Task(
        T.bracket(
          release: release,
          use: use,
        )(_f),
      );

  Task<A2> map<A2>(
    A2 Function(A) mapper,
  ) =>
      Task(T.map(mapper)(_f));
}
