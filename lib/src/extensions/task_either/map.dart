import '../../../task_either.dart' as TE;

extension MapTaskEitherExtension<L, R1> on TE.TaskEither<L, R1> {
  TE.TaskEither<L, R2> map<R2>(
    R2 Function(R1) right,
  ) =>
      TE.map(right)(this);
}
