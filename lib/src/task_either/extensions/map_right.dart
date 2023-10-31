import '../task_either.dart' as TE;

extension MapRightTaskEitherExtension<L, R1> on TE.TaskEither<L, R1> {
  TE.TaskEither<L, R2> mapRight<R2>(
    R2 Function(R1) right,
  ) =>
      TE.map(right)(this);
}
