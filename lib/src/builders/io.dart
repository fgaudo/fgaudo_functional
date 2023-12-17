import '../../../io.dart' as I;

final class IOBuilder<A> {
  const IOBuilder(this._f);

  final I.IO<A> _f;

  static IOBuilder<A> of<A>(A a) => IOBuilder(() => a);

  I.IO<A> build() => _f;

  IOBuilder<B> bracket<B>({
    required I.IO<B> Function(A) use,
    required I.IO<void> Function(A) release,
  }) =>
      IOBuilder(
        I.bracket(
          release: release,
          use: use,
        )(_f),
      );

  IOBuilder<B> flatMap<B>(
    I.IO<B> Function(A) f,
  ) =>
      IOBuilder(I.flatMap(f)(_f));
}

extension ToIOBuilderReaderExtension<ENV, A> on I.IO<A> {
  IOBuilder<A> toIOBuilder() => IOBuilder(this);
}
