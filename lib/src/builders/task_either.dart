import '../../../task_either.dart' as TE;
import 'task.dart' as TX;

final class TaskEitherBuilder<E, A> {
  const TaskEitherBuilder(this._f);

  final TE.TaskEither<E, A> _f;

  TE.TaskEither<E, A> build() => _f;

  TaskEitherBuilder<E2, A2> bimap<E2, A2>(
    E2 Function(E) left,
    A2 Function(A) right,
  ) =>
      TaskEitherBuilder(
        TE.bimap(
          left: left,
          right: right,
        )(_f),
      );

  TaskEitherBuilder<E2, A> mapLeft<E2>(
    E2 Function(E) left,
  ) =>
      TaskEitherBuilder(TE.mapLeft(left)(_f));

  TaskEitherBuilder<E, A2> map<A2>(
    A2 Function(A) right,
  ) =>
      TaskEitherBuilder(TE.map(right)(_f));

  TX.TaskBuilder<A2> match<A2>({
    required A2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      TX.TaskBuilder(
        TE.match(
          left: left,
          right: right,
        )(_f),
      );
}

extension ToBuilderTaskEitherExtension<L, R> on TE.TaskEither<L, R> {
  TaskEitherBuilder<L, R> toTaskEitherBuilder() => TaskEitherBuilder(this);
}
