import '../../../task.dart' as T;
import '../../../task_either.dart' as TE;

extension MatchTaskEitherExtension<L, R> on TE.TaskEither<L, R> {
  T.Task<A> match<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      TE.match(left: left, right: right)(this);
}
