import '../stream_either.dart';

extension FoldStreamEitherExtension<L, R> on StreamEither<L, R> {
  Stream<A> foldEither<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      FoldEitherStreamTransformer(
        right: right,
        left: left,
      ).bind(this);
}
