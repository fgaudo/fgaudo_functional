import '../../../option.dart' as O;

final class OptionBuilder<A> {
  const OptionBuilder(this._option);

  final O.Option<A> _option;

  static OptionBuilder<A> none<A>() => OptionBuilder(O.None());

  static OptionBuilder<A> some<A>(A a) => OptionBuilder(O.Some(a));

  O.Option<A> build() => _option;

  OptionBuilder<B> map<B>(
    B Function(A) some,
  ) =>
      OptionBuilder(
        O.map(some)(_option),
      );

  B match<B>({
    required B onNone,
    required B Function(A) onSome,
  }) =>
      O.match(
        onNone: onNone,
        onSome: onSome,
      )(_option);
}

extension ToOptionBuilderReaderExtension<A> on O.Option<A> {
  OptionBuilder<A> toOptionBuilder() => OptionBuilder(this);
}
