import '../../../task.dart' as T;

final class TaskBuilder<A> {
  const TaskBuilder(this._f);

  final T.Task<A> _f;

  T.Task<A> build() => _f;

  TaskBuilder<B> bracket<B>({
    required T.Task<B> Function(A) use,
    required T.Task<void> Function(A) release,
  }) =>
      TaskBuilder(
        T.bracket(
          release: release,
          use: use,
        )(_f),
      );

  TaskBuilder<A2> map<A2>(
    A2 Function(A) mapper,
  ) =>
      TaskBuilder(T.map(mapper)(_f));
}

extension ToTaskBuilderReaderExtension<A> on T.Task<A> {
  TaskBuilder<A> toTaskBuilder() => TaskBuilder(this);
}
