import '../../../either.dart' as E;

final class EitherBuilder<L, R> {
  const EitherBuilder(this._either);

  final E.Either<L, R> _either;

  E.Either<L, R> build() => _either;

  EitherBuilder<L2, R> mapLeft<L2>(
    L2 Function(L) left,
  ) =>
      EitherBuilder(E.mapLeft(left)(_either));

  EitherBuilder<L2, R2> bimap<L2, R2>({
    required R2 Function(R) right,
    required L2 Function(L) left,
  }) =>
      EitherBuilder(
        E.bimap(
          right: right,
          left: left,
        )(_either),
      );

  EitherBuilder<L, R2> flatMap<R2>(
    E.Either<L, R2> Function(R) f,
  ) =>
      EitherBuilder(E.flatMap(f)(_either));

  EitherBuilder<L, R2> map<R2>(
    R2 Function(R) right,
  ) =>
      EitherBuilder(E.map(right)(_either));

  A match<A>({
    required A Function(R) right,
    required A Function(L) left,
  }) =>
      E.match(
        right: right,
        left: left,
      )(_either);
}

extension ToEitherBuilderReaderExtension<L, R> on E.Either<L, R> {
  EitherBuilder<L, R> toEitherBuilder() => EitherBuilder(this);
}
