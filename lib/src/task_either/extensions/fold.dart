import '../../task/task.dart' as T;
import '../task_either.dart' as TE;

extension FoldTaskEitherExtension<L, R> on TE.TaskEither<L, R> {
  T.Task<A> fold<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      TE.fold(left: left, right: right)(this);
}
