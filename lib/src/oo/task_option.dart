import '../../../task_option.dart' as TO;
import 'task.dart' as TX;

final class TaskOption<A> {
  const TaskOption(this._f);

  final TO.TaskOption<A> _f;

  TaskOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      TaskOption(TO.map(mapper)(_f));

  TX.Task<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      TX.Task(
        TO.match(
          onNone: none,
          onSome: some,
        )(_f),
      );
}
