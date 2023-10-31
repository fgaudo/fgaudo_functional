import '../either.dart' as E;

extension FoldEitherExtension<L, R> on E.Either<L, R> {
  A fold<A>({
    required A Function(R) right,
    required A Function(L) left,
  }) =>
      E.fold(this)(right: right, left: left);
}
