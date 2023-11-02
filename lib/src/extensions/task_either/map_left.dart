import '../../../task_either.dart' as TE;

extension MapLeftTaskEitherExtension<L1, R> on TE.TaskEither<L1, R> {
  TE.TaskEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      TE.mapLeft(left)(this);
}
