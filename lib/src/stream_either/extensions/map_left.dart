import '../stream_either.dart';

extension MapLeftStreamEitherExtension<L1, R> on StreamEither<L1, R> {
  StreamEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      MapLeftStreamEitherTransformer<L1, L2, R>(left).bind(this);
}
