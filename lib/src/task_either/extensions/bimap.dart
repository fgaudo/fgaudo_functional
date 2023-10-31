import '../task_either.dart' as TE;

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
