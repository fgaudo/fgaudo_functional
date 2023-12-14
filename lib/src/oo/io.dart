import '../../../io.dart' as I;

final class IO<A> {
  const IO(this._f);

  final I.IO<A> _f;

  IO<B> bracket<B>({
    required I.IO<B> Function(A) use,
    required I.IO<void> Function(A) release,
  }) =>
      IO(
        I.bracket(
          release: release,
          use: use,
        )(_f),
      );

  IO<B> flatMap<B>(
    I.IO<B> Function(A) f,
  ) =>
      IO(I.flatMap(f)(_f));
}
