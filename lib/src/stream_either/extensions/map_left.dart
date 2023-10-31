import '../../common.dart';
import '../stream_either.dart';

extension MapLeftStreamEitherExtension<L1, R> on StreamEither<L1, R> {
  StreamEither<L2, R> mapLeft<L2>(
    L2 Function(L1) left,
  ) =>
      BimapEitherStreamTransformer(
        right: identity1<R>,
        left: left,
      ).bind(this);
}
