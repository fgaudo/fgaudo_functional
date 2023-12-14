import '../../../task.dart' as T;
import '../../../task_either.dart' as TE;

extension BimapTaskEitherExtension<L1, R1> on TE.TaskEither<L1, R1> {
  TE.TaskEither<L2, R2> bimap<L2, R2>(
    L2 Function(L1) left,
    R2 Function(R1) right,
  ) =>
      TE.bimap(
        left: left,
        right: right,
      )(this);
}

extension MapLeftTaskEitherExtension<L1, R> on TE.TaskEither<L1, R> {
  TE.TaskEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      TE.mapLeft(left)(this);
}

extension MapTaskEitherExtension<L, R1> on TE.TaskEither<L, R1> {
  TE.TaskEither<L, R2> map<R2>(
    R2 Function(R1) right,
  ) =>
      TE.map(right)(this);
}

extension MatchTaskEitherExtension<L, R> on TE.TaskEither<L, R> {
  T.Task<A> match<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      TE.match(left: left, right: right)(this);
}
