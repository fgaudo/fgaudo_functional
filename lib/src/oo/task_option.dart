import '../../../task_option.dart' as TO;
import 'task.dart' as TX;

final class TaskOptionBuilder<A> {
  const TaskOptionBuilder(this._f);

  final TO.TaskOption<A> _f;

  TO.TaskOption<A> build() => _f;

  TaskOptionBuilder<B> map<B>(
    B Function(A) mapper,
  ) =>
      TaskOptionBuilder(TO.map(mapper)(_f));

  TX.TaskBuilder<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      TX.TaskBuilder(
        TO.match(
          onNone: none,
          onSome: some,
        )(_f),
      );
}

extension ToTaskEitherBuilderReaderExtension<A> on TO.TaskOption<A> {
  TaskOptionBuilder<A> toTaskOptionBuilder() => TaskOptionBuilder(this);
}
