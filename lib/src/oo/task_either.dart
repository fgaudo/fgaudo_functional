import '../../../task_either.dart' as TE;
import 'task.dart' as TX;

final class TaskEither<E, A> {
  const TaskEither(this._f);

  final TE.TaskEither<E, A> _f;

  TaskEither<E2, A2> bimap<E2, A2>(
    E2 Function(E) left,
    A2 Function(A) right,
  ) =>
      TaskEither(
        TE.bimap(
          left: left,
          right: right,
        )(_f),
      );

  TaskEither<E2, A> mapLeft<E2>(
    E2 Function(E) left,
  ) =>
      TaskEither(TE.mapLeft(left)(_f));

  TaskEither<E, A2> map<A2>(
    A2 Function(A) right,
  ) =>
      TaskEither(TE.map(right)(_f));

  TX.Task<A2> match<A2>({
    required A2 Function(E) left,
    required A2 Function(A) right,
  }) =>
      TX.Task(TE.match(
        left: left,
        right: right,
      )(_f));
}
