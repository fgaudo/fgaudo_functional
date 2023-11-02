import '../stream_either.dart';

extension MatchStreamEitherExtension<L, R> on StreamEither<L, R> {
  Stream<A> matchEither<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      match(left: left, right: right)(this);
}
