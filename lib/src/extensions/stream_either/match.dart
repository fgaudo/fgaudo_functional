import '../../../stream_either.dart' as SE;

extension MatchStreamEitherExtension<L, R> on SE.StreamEither<L, R> {
  Stream<A> match<A>({
    required A Function(L) left,
    required A Function(R) right,
  }) =>
      SE.match(left: left, right: right)(this);
}
