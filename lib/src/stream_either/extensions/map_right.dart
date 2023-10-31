import '../stream_either.dart';

extension MapRightStreamEitherExtension<L, R1> on StreamEither<L, R1> {
  StreamEither<L, R2> mapRight<R2>(
    R2 Function(R1) right,
  ) =>
      MapRightStreamEitherTransformer<L, R1, R2>(right).bind(this);
}
