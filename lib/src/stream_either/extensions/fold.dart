import '../stream_either.dart';

extension FoldStreamEitherExtension<L, R> on StreamEither<L, R> {
  Stream<A> foldEither<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      fold(left: left, right: right)(this);
}
